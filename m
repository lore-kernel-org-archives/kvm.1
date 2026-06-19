Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC754654
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830535; cv=none; b=sMoX+hWw3PsWkJGeZxfiygTJXbsmGsXJY3SlkaOnDqkvc6P0Jq+99Yptrd7jcxwRIgjJvHvoPQbLzA6Of6hvb58LJ277OTUXHDpF73ZDXIUSYGwO5raP3P3o+W9Y19hh0yA7BsOZerDaw/qbpkMCwPgvdUH/U6DImGpwVP88p2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830535; c=relaxed/simple;
	bh=Lw+Zc6EmwceFHqlfSl3djKJqHCFN06SzVFMlxKOvGoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dVSYt7H9nT1PvBgughy8w79NyzhCvzbvBcOuHG3O+VVpIXScvTtWExaUZtB77SAbNXExwG2/k3F7rnPWu0MUuS3iajQrQttWN36BI6GyI9jpKzUjJnU4YL83rimiInzYPFNnPvRMa2fyUiNvznP5g43wooXO/ijl/3hxOZXPegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8ndkumH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8ndkumH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984EC1F000E9;
	Fri, 19 Jun 2026 00:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830533;
	bh=Lw+Zc6EmwceFHqlfSl3djKJqHCFN06SzVFMlxKOvGoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8ndkumHwwsNIReOT70Y8cq6iSyBu6J6/29BZ5lild5Q23mHqnjXHL/IZAQq4Lamw
	 Ips+IDtHIx4SkQHYKNZLSzq1ib4hlZeDi68GC7fOb+6K+EBeFNtqcgRrcfpICtT1vL
	 AZPclHeBu0k/qgh/J7Bbh0ypyL0Bm2PDN5SUqUv/VXgCpfF0Krd4UCKkGZ2w00wVRD
	 pE16uIuboIZtH17+KRjQ0gOhnhNHYiXVnS0Rgr3gNkOL9XAXMnK78N1gRzxq77MHFi
	 C4XnD7pl67bX1etqolh2RAM7NOvSpAVvNI50QAeGxUYrpN0qUkECF4NptmcmJe0ECU
	 fdYIpRKdWWBFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare
 for in-place gmem conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:55:33 +0000
Message-Id: <20260619005533.984EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `kvm_range_has_vm_memory_attributes` iterates over potentially mas=
sive ranges under `rcu_read_lock()` without yielding, leading to RCU stalls.
--

Note: The format of this report is altered to provide a free-form summary
without quoting the original patch code directly due to recitation restrict=
ions.

commit 05536cc2fad8dac656829127ace4d82d1b522580
Author: Sean Christopherson <seanjc@google.com>
Subject: KVM: Rename memory attribute APIs to prepare for in-place gmem con=
version

This patch renames the memory attribute APIs to include "vm_" in anticipati=
on
of moving PRIVATE tracking into guest_memfd. It introduces no functional
changes.

[Severity: High]
This is a pre-existing issue, but the kvm_range_has_vm_memory_attributes()
function in virt/kvm/kvm_main.c appears to iterate over a potentially massi=
ve
range under an RCU read lock without yielding.

The bounds for the loop come from the KVM_SET_MEMORY_ATTRIBUTES ioctl
handler (kvm_vm_ioctl_set_mem_attributes()), which does not place an upper
limit on the size other than preventing arithmetic overflow. If a user with=
 a
large memcg limit pre-populates a massive range, and then calls the ioctl
again on the same range, the loop using xas_next() inside the guard(rcu)()
block will iterate over the entire range.

Since it does not yield, a sufficiently large range (e.g., billions of
elements) could run for tens of seconds, causing an RCU stall or soft locku=
p.

Could this code drop the RCU lock and yield periodically, or process in
batches, to prevent unprivileged userspace from causing lockups here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D7
