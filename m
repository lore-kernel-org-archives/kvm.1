Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AD54654
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830570; cv=none; b=iSfxyqEFuE2rMFeb/xevmI++O+9V8CXP84NE+ebo8IZg70iIgd5gOLfuCgQKmmPshMu++j4A60arGQgff6soMBdoIbUB07VD+fISEopMkD2HQ/UE2VYTOVn4E6ElCr8UDRqPfhZQfgwFQ5FL2oJ+uBP7SsKlL/M6GzymDtEybqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830570; c=relaxed/simple;
	bh=Hgpw7oC2rq3RHu7hsYR2onH0kGMmiqkorC1TFJOPhv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pjTyfTbPYP+L2SFaMGAw/1Wawu5rK5e2ysH3dd4/OohPp4mav1ZVf9pf6jj1nrO9/9Ovq0E+G+QIbW1d9EfAghDktqDoPw64yRPUEdCWSjuhSKUMNO28WBeFSimiTJP0zTV7f4DWbsl1YMlig9DzQewaZOc7RmkDLDQiBcWXZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogkbA700; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogkbA700"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421B71F000E9;
	Fri, 19 Jun 2026 00:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830569;
	bh=uXmXzVc85gz/qcqW/jIGLZ5JjzHW+3PU4e+t0zSjEhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ogkbA700GziI3a2WPEFwNBwlWNR/hc18DBGkqLJ9wFVwgWk2Gu+9rpptgtUIyXLOX
	 m12tV2KEYiABQGpOkagP7SRuqeB/KDU7dw3eicgHsR5Zg7OIV+tu0Zqo/OD3dWCnZ8
	 NY0vRypUparIrjHoId9Q+2AZ2Di3LDdHFX5l50IKb9jS5QgnQZSYx2oMsb9D5/Eu7q
	 m721jytOz9xOmRp5fdOSf4EBGv6+hRvvm3e0ZK8Sm+E1Tb4WgaZ1DvxlTQR8UYHqmU
	 7QztSs5/BAu7FMANI6zIUmZbDZjAUJGJ+lQZ5IQNUYAF9WfnJKfUAz7TvT4hO084UV
	 q9TOj043svyAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 27/46] KVM: selftests: Rename guest_memfd{,_offset}
 to gmem_{fd,offset}
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-27-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-27-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:56:08 +0000
Message-Id: <20260619005609.421B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The renaming of 'guest_memfd' to the 'gmem_' prefix for local varia=
bles and parameters is incomplete across the selftests subsystem.
--

commit ce3052fec38d2438ddf1c5609c3518407024b32a
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}

This commit renames local variables and function parameters for the guest
memory file descriptor and its offset to use a "gmem_" prefix. No
functional changes are intended.

> Rename local variables and function parameters for the guest memory file
> descriptor and its offset to use a "gmem_" prefix instead of
> "guest_memfd_".

[Severity: Low]
This isn't a bug, but is this renaming incomplete?

The commit message implies a general rename across the selftests, but the
patch only updates the core library files (kvm_util.c and kvm_util.h). Other
test files still use the old naming conventions.

For example, in tools/testing/selftests/kvm/set_memory_region_test.c:

test_invalid_memory_region_flags() {
    ...
    int guest_memfd =3D vm_create_guest_memfd(vm, MEM_REGION_SIZE, 0);
    ...
}

And in tools/testing/selftests/kvm/guest_memfd_test.c:

static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
                                                  u64 guest_memfd_flags)

Should these remaining instances also be updated to the gmem_ prefix to
keep the internal naming scheme consistent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D27
