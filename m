Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6D330644
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846309; cv=none; b=Adl/nvFrtnfyIks/bRgoLlDk8g4FJSYxiWEtTrchXt/c++hJ6dNvkmDeBHg7U4nCsdU7PaVa94+xcLJdIWuU4xUzQnR+B96PsrfTeJOZRZ5xA9Lt0ZIvdkiB/ikDviIM2VrM7LR+Mu4wiJMNGW4IpyW67qtH6/0NFaA3wQxoli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846309; c=relaxed/simple;
	bh=Rd9QdKKfa0NEAVrVMnKN2JlPa/c2t2pc6FSX2X+Fodg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uYDUDsE6QtGRNlVZwAI5Y002NK38ezmZzFTJpExv+iu9PxWdNGbPzCBH6h4K3GqHDQpSMCxsV/wfFLaI6Gw+qhtlJBI45Wpv6Ck1bL6QJJoqAjows8FrPkNnaQqMG/udvMeOMRwjW1PnmwQ+ew8s54FptqbbNqI1Wc3v3C7yiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhAGbG4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhAGbG4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BB31F000E9;
	Wed, 27 May 2026 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846306;
	bh=NDscbBjS1G4L8RTxRn1+UGK772Oing3sCwNQ+B0ujnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EhAGbG4KrDplu7KxmYdOYHBUwL282kzRWZH+G6ztoxzS68TxevtuplgXBWlESPY1y
	 qLW4abo7yiRGit+Y7/Nx4tldnhkQ4R85QpG+Sn6v7OI2tbiDga99B//beO2zV+E8Fw
	 Ag5M5q/2czWJ7TxX4wi+KJ/Ly+zD0c8YeuZKrq4lbLQxqRDLmJJXycBLuBLfWXb31E
	 W3wnH5ltzT/A9VmGkRMPTmWKYs1Utr+viHkF0pGHUW7dJV1Ckt8U+RdzyDfy1baq9+
	 ZKQc8Qt1KEbJ44KdSB3pRyI5xw6DN8V9jlXEkstthle8o0fHF+KfYioubfUo+swTxl
	 GKzKFcPSOoWXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 38/43] KVM: selftests: Provide common function to set
 memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260507-gmem-inplace-conversion-v6-38-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-38-91ab5a8b19a4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 01:45:06 +0000
Message-Id: <20260527014506.81BB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The function incorrectly routes all attribute updates through gues=
t_memfd if the host globally supports it, crashing on non-guest_memfd regio=
ns and skipping VM-level updates.
- [Medium] An integer overflow in the `end` address calculation can cause t=
he memory attribute setting loop to be silently bypassed.
- [Low] Using min() with mixed underlying types (gpa_t and size_t) causes a=
 strict compilation warning/error.
- [Low] Silent suppression of zero-sized requests on the guest_memfd path d=
iverges from the VM ioctl path behavior and masks invalid API usages.
--

commit 16550ec77b955792a5b53a3ee07ba0330c0c629a
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Provide common function to set memory attributes

This commit introduces vm_mem_set_memory_attributes() to handle setting
memory attributes for a guest physical address range. It refactors existing
shared and private memory functions to use this new helper. It also routes
attribute updates either through guest_memfd or VM-level ioctls based on
global host support.

> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testi=
ng/selftests/kvm/include/kvm_util.h
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
[ ... ]
> +static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, gpa_t=
 gpa,
> +						size_t size, u64 attrs)
> +{
> +	if (kvm_has_gmem_attributes) {

[Severity: High]
Can this route all attribute updates through guest_memfd if the host
globally supports it, crashing on non-guest_memfd regions?

Existing tests intentionally create non-private memslots (flags =3D 0) and
call vm_mem_set_private(). Because this branches solely on the global
kvm_has_gmem_attributes capability, it will call kvm_gpa_to_guest_memfd()
which asserts that the region is a guest_memfd region:

TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD)

This can cause these tests to crash.

Also, due to this strict branching, non-guest_memfd regions bypass
vm_set_memory_attributes() entirely, so their VM-level attributes are never
updated.

Could we dynamically check if the specific memory region has the
KVM_MEM_GUEST_MEMFD flag before choosing the routing path?

> +		gpa_t end =3D gpa + size;

[Severity: Medium]
Does this calculation overflow end if size is sufficiently large, such as
when testing boundary conditions with (size_t)-1?

If gpa + size overflows, end becomes smaller than gpa. The loop condition
addr < end would then evaluate to false immediately, and the function would
silently return without making any ioctl calls to KVM.

Prior to this patch, size was passed directly to the kernel ioctl which
handled bounds validation.

> +		off_t fd_offset;
> +		gpa_t addr;
> +		size_t len;
> +		int fd;
> +
> +		for (addr =3D gpa; addr < end; addr +=3D len) {

[Severity: Low]
Does this loop silently mask invalid test configurations for zero-sized
requests?

If vm_mem_set_private() is called with size =3D=3D 0, end evaluates to gpa =
and
the loop condition addr < end immediately fails, returning silently.

In contrast, the fallback else path (vm_set_memory_attributes()) routes the
zero-size request to KVM, which rejects it with -EINVAL and triggers a
TEST_ASSERT failure.

> +			fd =3D kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);
> +			len =3D min(end - addr, len);

[Severity: Low]
Does this cause a compilation warning due to mixing underlying types?

end - addr is of type gpa_t (u64), while len is size_t. The standard kernel
min() macro performs strict type checking, which will generate a warning
about comparing distinct pointer types. Since KVM selftests are built with
-Werror, this can cause a build failure.

Could this use min_t(size_t, ...) instead?

> +
> +			gmem_set_memory_attributes(fd, fd_offset, len, attrs);
> +		}
> +	} else {
> +		vm_set_memory_attributes(vm, gpa, size, attrs);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-gmem-inpla=
ce-conversion-v6-0-91ab5a8b19a4@google.com?part=3D38
