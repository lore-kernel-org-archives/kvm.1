Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CE32B11F
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935214; cv=none; b=q47/0+UE/DeZ/37PtIdgGaikaLKjNm+hqxx0DeLROGM+l0kaw9tHxtefCSJjwqz9rkOl5GN81FvSGkrHCHWU+Y1p8Vt9c7NeU0qg+BAmf1VnL+lBUd3K/oG7KtwfE3Nu3vFv3Xsr0beROK7jUAm3mE36R6TYDrXgtGh8Ivj0AS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935214; c=relaxed/simple;
	bh=n2pFqhOeZHDe/xMcy5agbg/pMto8LhEIEHQ/6wijhlc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cWtXXQmYa+zEAXxlphx/xwMLgLy9iU6x5bSdyTc19VTJDY90qt8SCmKjFkXoYAp5mA6p0dSyHmQWcyi2yyz7aV9NIFWc5X8NjyDrhOOo7zIADVHIwz17nKdzZXODSu8KUnbeZ6/mOcFml283HP6weW4EvKdop6oa+1qzIAGd5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9ipRJIi; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9ipRJIi"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68fa01a8b02so3962893a12.1
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780935211; x=1781540011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xL7fKZb0tbUDjFUdPWFnb0YOE1teoOM2ki+nlFuHpDE=;
        b=H9ipRJIiE7+T6QaFuZbDqQh5M0bOrRF/QqyIYXr8e25qF2AWdUbtNisrgqGmdnTAZM
         l7RX5qwENG3JUBw8DlNeWdeAR+FDEYMjbK+Ur4h1IYhSOxJPeFbmIBS3t3LKAIlhjXA2
         FncM02OW2YIPp1AzEi36nEkS52IhT/dZN+VBCpreNYiYHfELsE8fqI0kmo58VHBVddzm
         2HVoaLvkoZsMyrxeZjwJZpckcda5W5zqI4UhuvyStDBB/9ULg/Gunm9R3IwLLOwhalCV
         Wn9IosmL0d78BdeboMWGEDEFu2vSIcNxKpnIWBD/2aQaR0Jw6YkdZ1imio2bvzAvnZC7
         qGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935211; x=1781540011;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xL7fKZb0tbUDjFUdPWFnb0YOE1teoOM2ki+nlFuHpDE=;
        b=B1MyQ0BoouHCs4ibl7C6UHCj8Et3BWWAw3mL3zi7MBT8n0tG4anvf1Ida++rCDFAT2
         tzADcpNQTyOYDaGssdr4e30AN0DGCaLGTxU2HMaDuIHTTr6ZLJy+kY70Mn6m7r18cJpJ
         ibzVkJwhzpzG0EjL3x+tOU97VS5PAEK6pnja1rdZZkgT7458tFkD421gHoaHwqbcznPL
         rEjpIEDeQ3WPa5xVespvAfEJr3q2hfL8NiW/z09WNrL4eTU+BEdpKDLrdB07RrHiIf+6
         QCKlnX+DBmVxlMlid0T42GSrqavA6L2tWCkMbAsyyTF4X4aPGalLHbyIUgvBGdd4s+Bh
         j1Vg==
X-Gm-Message-State: AOJu0YzGehebIXrdyB60lC4Zk2LuuR+XAPCSWXP6H9IdHvxzIF0SWFS9
	PCxHy+/jLqHTj2a62BU4+vjRzYV3kK4BSSir6QeP6D9F5tmj3yXUu0/nNd6i6MI7tq1rOMmDIoZ
	nYhKEJKXXbwUqWuj8xA==
X-Received: from edag15.prod.google.com ([2002:a05:6402:320f:b0:691:acc4:471e])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:12c1:b0:691:6fb6:dada with SMTP id 4fb4d7f45d1cf-6916fb6deb3mr2797490a12.4.1780935210801;
 Mon, 08 Jun 2026 09:13:30 -0700 (PDT)
Date: Mon, 08 Jun 2026 16:13:29 +0000
In-Reply-To: <20260605172634.95C811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8730c0e11acbd0d645a8b7187cd5cd7de373380e.1780676742.git.tarunsahu@google.com>
 <20260605172634.95C811F00893@smtp.kernel.org>
Message-ID: <9huzbjdlxb6e.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 04/10] kvm: kvm_luo: Allow kvm preservation with LUO
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

sashiko-bot@kernel.org writes:

> [ ... ]
>> +#ifdef CONFIG_X86
>> +	ser->type =3D kvm->arch.vm_type;
>> +#else
>> +	ser->type =3D 0;
>
> [Severity: High]
> Does hardcoding the VM type to 0 on non-x86 architectures discard require=
d
> state?=20
>
> For instance, on ARM64, the VM type parameter encodes architectural
> information such as the Intermediate Physical Address (IPA) size and
> protection flags.=20
>
> Will restoring the VM with type 0 cause the new kernel to initialize the
> VM with default settings, potentially leading to a mismatched memory layo=
ut?
>
Ack. Other than x86_64 arch, vm_type field is not part of struct
kvm_arch. But the type is used in creating the new kvm which we will
need on retrieval path. Currently only ARM64 supports the guest_memfd
other than x86_64, So I suggest the following:

-#ifdef CONFIG_X86
+#if defined(CONFIG_X86)
 	ser->type =3D kvm->arch.vm_type;
+#elif defined(CONFIG_ARM64)
+	ser->type =3D kvm_phys_shift(&kvm->arch.mmu);
+	if (kvm_vm_is_protected(kvm))
+		ser->type |=3D KVM_VM_TYPE_ARM_PROTECTED;
 #else
 	ser->type =3D 0;
 #endif

>> +
>> +static atomic_t restored_vm_id =3D ATOMIC_INIT(0);
>> +
>> +static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
>> +{
>> +	char fdname[ITOA_MAX_LEN + 1];
> [ ... ]
>> +	snprintf(fdname, sizeof(fdname), "%d",
>> +		 atomic_inc_return(&restored_vm_id));
>
> [Severity: Medium]
> Since standard VMs use their native file descriptor numbers as fdname, an=
d
> those typically start from low numbers, will this auto-incrementing count=
er
> guarantee namespace collisions?=20
>
> A collision here would result in a duplicate directory error in
> kvm_create_vm_debugfs(), which would cause debugfs statistics for newly
> created VMs to be skipped.
>
Yes, I agree, I have a comment in cover letter, Would be happy to
discuss alternative, if this is really an issue.

>> +
>> +	file =3D kvm_create_vm_file(ser->type, fdname);
> [ ... ]
>> +static void kvm_luo_finish(struct liveupdate_file_op_args *args)
>> +{
>> +	struct kvm_luo_ser *ser;
>> +
>> +	/*
>> +	 * If retrieve_status is true or set to error, nothing to do here.
>> +	 * Already cleaned up in kvm_luo_retrieve().
>> +	 */
>> +	if (args->retrieve_status)
>> +		return;
>> +
>> +	if (!args->serialized_data)
>> +		return;
>> +
>> +	ser =3D phys_to_virt(args->serialized_data);
>> +	kho_restore_free(ser);
>
> [Severity: High]
> Can this result in a double-free on the successful retrieve path?
>
> In kvm_luo_retrieve(), kho_restore_free() is explicitly called on success
> before returning 0:
>
> 	args->file =3D file;
> 	kho_restore_free(ser);
>
> 	kvm_uevent_notify_vm_create(kvm);
> 	return 0;
>
> Since the retrieve is successful, args->retrieve_status will be 0 here,
> and this function will call kho_restore_free() again on the same
> serialized data.

This is incorrect: retrieve_status is 1 when it is successful. So this
review comment is incorrect.

>
>> +}
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.=
git.tarunsahu@google.com?part=3D4
