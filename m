Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298F23F417
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151275; cv=none; b=n7zkB6/pN6SShzJ6O74K7bL89fw6awQ/flq58u65BJQMipmsp2EybDULO78AJ4qsngBgRt2wSGDGiZZhx8xGDd2/gaNVzMR+HYYYVMEwIfKrEL9MHj92xqKexkAV76THY5gsqnoXJVW5dl4zspn7ka21cGwx3yY+SAXU9hMU+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151275; c=relaxed/simple;
	bh=iyQe+pL/3qPU33nPIdpLKz57awtQq/UTiot1l3CNXuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tAs/xtvpHlEPaZFu+eq/JydHo9eMteXo6Sq4fCo0+f3fOHAbJ5g9SS5IGA6D+Fa+rve0ODYxLvjHbr37FqJ2c8pVSWX/lpfUn4pAe41OqON+KtNqiAJI6Y4nF93zuy1FNZTkABC3cijL4lJLpSChchOYB0jdEBtJfacLOgLLcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mzt4NTwO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mzt4NTwO"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d0d71c61so1488418b3a.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151274; x=1779756074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsEGdCFfxGMCvGZWZskHGM9DemFLQH+gRUHh+E9LVVo=;
        b=Mzt4NTwOxuV09oLVBp+06tXvvjYxrxILCFf09FH3LYFkEcylkHjTeRAALv4J3GFn2T
         fukTbp91lxvcmz3iag2T+f5GyEa4J2WpqwbpLGrECQS+dNHB3Xdn0qJtAmYhY3t8lmmv
         OOnLLj72/e1HBe9nhPEM2Dril+vdvB/gKh+I2psmyC6CP51v7M/qCWfWeHlTy6vJ8vVq
         drFgOAUAA/j4/KTtN/5cAFuXXBdeilS91oFKq065NvDCrzWU0SCT44VKXxLdVNrFAwey
         WUsDCyfgpVjXaZfPuQUdBZLVqoK3Kyc2tQTGr3fkbmMzGrlu4oLEKwE+rmTxddJojF4W
         qz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151274; x=1779756074;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MsEGdCFfxGMCvGZWZskHGM9DemFLQH+gRUHh+E9LVVo=;
        b=IvuhgPe3JIo2WsjhzJx50j+bxAGYoXzRhsZyEBu/VwOl0xcR9L3+839SuvjAxE/XY0
         FldKSgBhEs1d90HbxTnHu4int1rMyx2/x1M/TLlmedVI3JXcGlYkr1onXWRMceTIdLQS
         kJm/VrgER3whM+RdkoKnRJQH6VtBTB7lq8bkSPa+hlR7RxjGMgcR5qtGqtRDF8Rm6cNl
         ZfyrNXHiz3yG/51mayVIeUiUWWH3uS5bb57+WIgUgi+pATToq/OA7/sCrqoeN16f4nnL
         IUihwdHxkdasCi0IE0AWmUBp4DCAnvpNm3A0x0n3jUqJqYJOspImi5MPjKPtLDr4n2CM
         4Eaw==
X-Gm-Message-State: AOJu0YwkIXtkU1BM343Vr9R0AN+AfMIPfVrA+xUbeDVD5F8N5IVt44WT
	vGWhv4L8b+fJT3DB1XES6Am5uW4gxDR6xHIRqbKZn2NetQ5oqNsQyng35N58dyOw7Kq/iTizn71
	VUkW4hQ==
X-Received: from pfbdu7.prod.google.com ([2002:a05:6a00:2b47:b0:82f:7242:4cb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca4:b0:82c:6b1b:7ad4
 with SMTP id d2e1a72fcca58-83f33bc808emr15585266b3a.3.1779151273243; Mon, 18
 May 2026 17:41:13 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:36 -0700
In-Reply-To: <20260428012503.1213654-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428012503.1213654-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915114145.2231400.507167605132512102.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Include sys/mman.h *and* linux/mman.h,
 via kvm_syscalls.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 18:25:03 -0700, Sean Christopherson wrote:
> Include both linux/mman.h (the kernel provided version) and sys/mman.h (t=
he
> libc provided version) throughout KVM selftests, by way of kvm_syscalls.h
> (which should have been including sys/mman.h anyways).  Pulling in the
> kernel's version fixes compilation errors with the guest_memfd test on
> older versions of libc due to a recent commit adding MADV_COLLAPSE testin=
g.
>=20
>   In file included from include/kvm_util.h:8,
>                    from guest_memfd_test.c:21:
>   guest_memfd_test.c: In function =E2=80=98test_collapse=E2=80=99:
>   guest_memfd_test.c:219:47: error: =E2=80=98MADV_COLLAPSE=E2=80=99 undec=
lared (first use in this function); did you mean =E2=80=98MADV_COLD=E2=80=
=99?
>       219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE),=
 -1);
>           |                                               ^~~~~~~~~~~~~
>     include/test_util.h:62:16: note: in definition of macro =E2=80=98TEST=
_ASSERT_EQ=E2=80=99
>        62 |         typeof(a) __a =3D (a);                               =
             \
>           |                ^
>     guest_memfd_test.c:219:47: note: each undeclared identifier is report=
ed only once for each function it appears in
>       219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE),=
 -1);
>           |                                               ^~~~~~~~~~~~~
>     include/test_util.h:62:16: note: in definition of macro =E2=80=98TEST=
_ASSERT_EQ=E2=80=99
>        62 |         typeof(a) __a =3D (a);                               =
             \
>           |                ^
>=20
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: Include sys/mman.h *and* linux/mman.h, via kvm_syscal=
ls.h
      https://github.com/kvm-x86/linux/commit/6d3790bc689d

--
https://github.com/kvm-x86/linux/tree/next
