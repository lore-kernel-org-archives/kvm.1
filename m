Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B643AE188
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943219; cv=none; b=knpo9Zag2mdyH5WtUPnfQhokUbvyXLr09W6ctDx6IoPNk6BufQlGlhW25lHx3KiUZNVoYphZutXsfSamtrf8YcYJs472E5FyBmpuHOO5irUqrl6n0Z497TFHc+FtNB8pHqEyKFaW3rglNTH6JjLWsbtP1c9aweyQaqfGDDSN3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943219; c=relaxed/simple;
	bh=VtPbXJcQD8aAoOfXGNNyaFs2IxqUgTcWCdXJamVavio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFTq8knif16yMHDwpBBqTD/AYaObuxWX+U3W6b3EOvXPlt/UYXcd33yV8gF9tc+57VOywIBYPMyEs5S0uS0IMisiYDLUzaczdf7WpsO4rPa6fNkOC8/5gxNpYMATfqXKYaE7v6UwPcemwV8JqrIlg9aC8JhdtWfcjh9iOM/DkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJv0+4H/; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJv0+4H/"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-beb5131c31cso238012566b.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780943217; x=1781548017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWfuFGQtFl9xemEBK6hAwxQUYib3QQYLIakJAgyEoEE=;
        b=iJv0+4H/f0vd9BSxnoRnsMBa7RAzqQQs2w02vqh9T59QkfcS7kOZ1uhVBzBU4hghrO
         hTPr8d7dQVCX2KOlubWA4Dam5hzKjhdOAs4e0x5OyShtGeKZzrH150YV4pwerQiuprYp
         fMKLsDmSM9idIC1pGgiOwg0mfme6N1oBRbML9PT8r7P9o7CulsCCS4phtmlPjHtUHvdt
         jl53hbLNbA7Q0Lc/AnrNtDZAIRPWiEbTVym3cEeFQ5PTbA3gPbu9Vb71Pxiu+m58tt+L
         wFHnkqKwU1Bq7w1lscESCqV+evbsk+rEMHzV+BqRdr61rJx1ToY7VvpPxRUGXw/f5+ZQ
         KolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943217; x=1781548017;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kWfuFGQtFl9xemEBK6hAwxQUYib3QQYLIakJAgyEoEE=;
        b=fJ67WWinsyS6wqnjz/+k9DD1ehkFedjrCw62KErlboPxYJgKYOKd0iyGBxKoW58iT7
         u1bo1heFAvfopnqFapekrt4/1i2iP/ibUuMjS6LQ0bVz8WaInml4njuSUpTdiGC7qnF3
         sXV13mgnfOBksLizy7M3jYEbLQF2ou2IhVPspBXPEbh1HmqaXLkpU2ILbyTdHzo1Sbqd
         j1CE22nFl0dcHtRhzEA4tcqnigth5+BeQAaeuzyqfJWI7WK9KSqkBciuFzlF9tZCXhh/
         D7vV0Xgi0CkD3wHTQmj7BRyTG6CU1iW1vNgOKPsNpluRPKXVHxIgliklVBH7+8ehxEzP
         Y6nw==
X-Gm-Message-State: AOJu0YzLzizjtYDD6RkLUVHHmxucVMAQoKOyrpz76uIo/HYVOHmLC07Q
	ln9gHjJ37jWqNIB3rX6z66ffK/PeD3fgBLVImU87t8F6ifZkGLSLrA4jyrY228yyOAITYgsIUWE
	qeKloftig+hajNfsCmw==
X-Received: from ejcxa14.prod.google.com ([2002:a17:907:b9ce:b0:bed:b4b3:da8b])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:267b:b0:bd1:fe8f:59ab with SMTP id a640c23a62f3a-bf37234c4fcmr548468666b.23.1780943216517;
 Mon, 08 Jun 2026 11:26:56 -0700 (PDT)
Date: Mon, 08 Jun 2026 18:26:55 +0000
In-Reply-To: <20260605172249.B9A691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <deb20fbe3584a8c6bfda276447fe464c6553737d.1780676742.git.tarunsahu@google.com>
 <20260605172249.B9A691F00893@smtp.kernel.org>
Message-ID: <9huz33ywyjkg.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 10/10] selftests: kvm: Add guest_memfd_preservation_test
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

>
>> +	session_fd =3D luo_create_session(dev_luo_fd, SESSION_NAME);
>> +	TEST_ASSERT(session_fd >=3D 0, "Failed to create LUO session");
>> +
>> +	ret =3D luo_session_preserve_fd(session_fd, vm->fd, VM_TOKEN);
>> +	TEST_ASSERT(ret =3D=3D 0, "Failed to preserve VM file descriptor");
>
> [Severity: Medium]
> Since this test creates a VM with vCPU 0 and preserves the VM file descri=
ptor,
> but doesn't preserve the vCPU file descriptor, will vCPU 0 still be retai=
ned
> in KVM's state for phase 2 without a way to access it?

This is not the scope of the test.
>
>> +
>> +	ret =3D luo_session_preserve_fd(session_fd, gmem_fd, GMEM_TOKEN);
>> +	TEST_ASSERT(ret =3D=3D 0, "Failed to preserve guest_memfd file descrip=
tor");
>
> [ ... ]
>
>> +static void do_phase2(void)
>> +{
>
> [ ... ]
>
>> +	vm =3D vm_create_from_fd(retrieved_vm_fd, shape);
>> +
>> +	u64 nr_pages =3D 2048; /* 8MB is plenty for slot0 pages */
>> +
>> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, =
0);
>
> [Severity: Medium]
> Does this code attempt to overwrite existing memslot 0 with a new userspa=
ce
> address without deleting it first?
>
> Since the VM's internal memslots are retained in KVM kernel state when
> preserved, redefining slot 0 with a new userspace_addr violates KVM's mem=
slot
> mutability rules and will likely cause KVM_SET_USER_MEMORY_REGION to fail=
 with
> -EINVAL.
Not preserving the memslots. Only preserving the guest_memfd which is
attached to memslot 1.

>
>> +	kvm_vm_elf_load(vm, program_invocation_name);
>> +
>> +	for (int i =3D 0; i < NR_MEM_REGIONS; i++)
>> +		vm->memslots[i] =3D 0;
>> +
>> +	struct userspace_mem_region *slot0 =3D memslot2region(vm, 0);
>> +
>> +	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_si=
ze);
>> +
>> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SI=
ZE, NULL,
>> +				   retrieved_gmem_fd, 0);
>
> [Severity: Medium]
> Will this also trigger an -EINVAL error from KVM?
>
> Similar to slot 0, redefining the guest_memfd memslot (slot 1) without ex=
plicit
> deletion first also violates KVM's memslot mutability rules.

reattaching the guest_memfd not preserving the memslot mapping. so this
is not valid here.
>
>> +
>> +	for (size_t i =3D 0; i < GMEM_SIZE; i +=3D page_size)
>> +		virt_pg_map(vm, gpa + i, gpa + i);
>> +
>> +	vcpu =3D vm_vcpu_add(vm, 0, guest_code_phase2);
>
> [Severity: Medium]
> Will this blindly recreate a vCPU on the preserved VM, resulting in an
> immediate -EEXIST failure?

Incorrect, THere was no preservation of vCPU.
>
> Because the entire VM state was preserved in phase 1, vCPU 0 already exis=
ts in
> KVM's state. Calling vm_vcpu_add() for vCPU 0 again causes KVM to reject =
the
> duplicate KVM_CREATE_VCPU request.

No. Only guest_memfd and vm file was preserved. vm_file only preserved
with vm_type and everything else was recreated so, incorrect review.

>
>> +	kvm_arch_vm_finalize_vcpus(vm);
>> +
>> +	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.=
git.tarunsahu@google.com?part=3D10
