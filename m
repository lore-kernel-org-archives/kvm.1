Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28633101CE
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680395; cv=none; b=m6ZswwQSHiy4blgnH+CZ39Ar2qs0XKF/OqDJijvfm13mIFJvY/wnWWw61QLmVFFkHPfxms7u+/cOE1A8m0ZS7qeP7MTdqIdq0DBj0Gpo6qyP2G4l6Zz+WC1GRp4ZvfJ+ZXJ4Zwu4Hx1Tr9DDWTg3q5uWCvgNELLl81jkcCb6LWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680395; c=relaxed/simple;
	bh=obLjybeKRSjooqH2EXAuPMHrupj5rYhfLbW54/+WQUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G1B4nHWn6eWE7uyxElBeTkaPmFxO/uvEtGLwS7fAir9OzKeKM6JA59BFV0PkZ6lSe/2KecGvP+Hqdl+o+za5fsUxf/FDGrVWDLsPc+lKpAMsR133IQ5Yb3KSapYa981QsGvqPLY/w8uccCSDLC7qg8BCbHFT5CEKl24vY0uausU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8yIap9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8yIap9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C811F00893;
	Fri,  5 Jun 2026 17:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680394;
	bh=V5QwEmJ9oedrq12Hxks2aSvWLwA1NOk9geg1plblPhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8yIap9/RU4jNw7STG0ghV/8V77dmY+Dio9GZbQ562RAmmfQSGlnIM5EifbjlUvIa
	 7dhdliR45/ZWIN3o0LpePS6/Btm2P5C26OnX1dwTpC/gSsCnAYdlDMlWr6c8/esa9q
	 c5p7arOB2MrmI250Xnrv/T4/jBgVkpXjB3+Wk2MmlKMSFNX04Uv2Z2Cw+8h5ptv1Y6
	 16xTD+S+yBxCT8Bf6FV+zj2FIs6jN6Y2JCiug9MhHw/SA4SuJMDtmONWOSZjJIlEvj
	 Jf7fdl5VvxDkwMuUHjJFIsYNIYoTDhEY1xNg8e/MrSSI0duRO8tOe5RWjWv90sp6lU
	 Zw7GyJCz8gw+Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/10] kvm: kvm_luo: Allow kvm preservation with
 LUO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <8730c0e11acbd0d645a8b7187cd5cd7de373380e.1780676742.git.tarunsahu@google.com>
References: <8730c0e11acbd0d645a8b7187cd5cd7de373380e.1780676742.git.tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:26:34 +0000
Message-Id: <20260605172634.95C811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KVM live update silently drops the VM type on non-x86 architecture=
s, leading to incorrect VM initialization during restore.
- [High] Double free attempt of KHO serialized data on the successful retri=
eve path triggers a kernel warning.
- [Medium] Debugfs directory name collision for restored VMs silently drops=
 statistics for new VMs.
--

commit ded3fe4d8e96caf44b395f665f8fedc9e63e601b
Author: Tarun Sahu <tarunsahu@google.com>

kvm: kvm_luo: Allow kvm preservation with LUO

Introduce KVM VM preservation support for Live Update Orchestrator.
This registers an LUO file handler for KVM files to serialize and
deserialize necessary VM state across live updates.

> diff --git a/virt/kvm/kvm_luo.c b/virt/kvm/kvm_luo.c
> new file mode 100644
> index 0000000000000..25619f94ace5b
> --- /dev/null
> +++ b/virt/kvm/kvm_luo.c
[ ... ]
> +static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
> +{
[ ... ]
> +#ifdef CONFIG_X86
> +	ser->type =3D kvm->arch.vm_type;
> +#else
> +	ser->type =3D 0;

[Severity: High]
Does hardcoding the VM type to 0 on non-x86 architectures discard required
state?=20

For instance, on ARM64, the VM type parameter encodes architectural
information such as the Intermediate Physical Address (IPA) size and
protection flags.=20

Will restoring the VM with type 0 cause the new kernel to initialize the
VM with default settings, potentially leading to a mismatched memory layout?

> +#endif
> +
> +	args->serialized_data =3D virt_to_phys(ser);
> +
> +	return 0;
> +}
> +
> +static atomic_t restored_vm_id =3D ATOMIC_INIT(0);
> +
> +static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
> +{
> +	char fdname[ITOA_MAX_LEN + 1];
[ ... ]
> +	snprintf(fdname, sizeof(fdname), "%d",
> +		 atomic_inc_return(&restored_vm_id));

[Severity: Medium]
Since standard VMs use their native file descriptor numbers as fdname, and
those typically start from low numbers, will this auto-incrementing counter
guarantee namespace collisions?=20

A collision here would result in a duplicate directory error in
kvm_create_vm_debugfs(), which would cause debugfs statistics for newly
created VMs to be skipped.

> +
> +	file =3D kvm_create_vm_file(ser->type, fdname);
[ ... ]
> +static void kvm_luo_finish(struct liveupdate_file_op_args *args)
> +{
> +	struct kvm_luo_ser *ser;
> +
> +	/*
> +	 * If retrieve_status is true or set to error, nothing to do here.
> +	 * Already cleaned up in kvm_luo_retrieve().
> +	 */
> +	if (args->retrieve_status)
> +		return;
> +
> +	if (!args->serialized_data)
> +		return;
> +
> +	ser =3D phys_to_virt(args->serialized_data);
> +	kho_restore_free(ser);

[Severity: High]
Can this result in a double-free on the successful retrieve path?

In kvm_luo_retrieve(), kho_restore_free() is explicitly called on success
before returning 0:

	args->file =3D file;
	kho_restore_free(ser);

	kvm_uevent_notify_vm_create(kvm);
	return 0;

Since the retrieve is successful, args->retrieve_status will be 0 here,
and this function will call kho_restore_free() again on the same
serialized data.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.gi=
t.tarunsahu@google.com?part=3D4
