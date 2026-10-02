Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C73CE4BE
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979386; cv=none; b=Yr9kghZ3WkQDwdRPat84LiGfd9TzqyDFuMh/Lp6fRQOPW+ojRHpQzzJnPaExG7h8vGTkA/xxbJOS53K9ZkP+1+fyg0u9Pv4E0yioKtV11oUp2E8t1jm/UX4l8+jXJwwUPMbgflznAo0SDWo5GXswZCuMwkj2reKa/yhUj68VM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979386; c=relaxed/simple;
	bh=K9Rjfs4Qr7oUSRMr5nl0YpdYHF+TKIqpiiDrDAgieAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EtJVsCNw5yxmgNusxaOHaMXZBYCt2tXnpSsqEaGxZH25g/ayzqZYcYxhghVl8wRAQPvAcxxq3cWdsc+M9nY/TAmlHoNhfQu027OF3o4cQEqNup5RWav9dmR2GJyWGv6dtX1QSqIy99LPWgY+m7EM1j7D9fzT4Aqetu2Z6zxeDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HngVvTTK; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HngVvTTK"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2d3a3ff86so1053285ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790979384; x=1791584184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZUOmUpFAdn6kAClohBDNQiVlfBYiZoDgK+pqSPmkXA=;
        b=HngVvTTKyEOnn5b6Sn5FG6cV8XR/RaiIAVRZo3mhMGQntDCRKeDR2t3je5mJ0aHhGT
         ChjrWqRZOsGBV2H7lL7itN+4yOcnoF+k78j5QQrgODPXkXNTJnworxqg4H+XnF7Ov4pi
         UZO+Hf5QN3Jtch1LlipCSWUwtLRZoxMIKTqEKEg/J9eb4HH34kt+YoLy7XMYmFunlt02
         VGSWdPNoloUyIW78c0fitLmEMhkhUuTxnMFwbuj3jlJesEXsrRrnP2qhM2QRugwTMZW8
         aGLlSJTufswaI7/hiEFQqqscIDC0Hmuvc7w3Q+ixBf+6c6AdYsQzjTGNHSuC5jPElmEA
         phdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790979384; x=1791584184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZUOmUpFAdn6kAClohBDNQiVlfBYiZoDgK+pqSPmkXA=;
        b=IJ8Vm2n6pyR1sW6LH/cRyuHPa1RaMttXsEkzsszRgsbtbeVT0lsWiJDUH3GIe6/Lng
         tzRtV2QlbrcC03JGw47Zg0l0f9kgSYXZFFfhQ4qD0mlNtl99ZaMulqZm63B4NVgdcDxI
         I40bujR/kGLjcpSi8FGUCWI5Ty3GRttm1pP3jyEWhkdlA3ZaM+5IxKPfC+WVj5iijQa6
         WGqDs6YD/CzwOlwwFp6NJEh7n5ULozuBY4jYzvaJhgHLshkP0/jS7AQav8HoDhlKnCc3
         uP567d6Pxncmy9TUpUm4uTKuv3eGiwBZSvSrZvbKI00CSYKAzz5Q0G1OHmejgY/LToEI
         GQrw==
X-Gm-Message-State: AFq9FYJ+LD7ouycqcpiEn9XTaqbZz+LZFk1kJEKR2fQlbu2FapONnuIb
	zTX1SfjS6b3gIQXLvpMmQ9dV55TejJ/HSBFbpY5TlaIa8tSCniJbtbEqCKH0eNq1K10yMxc8utn
	BhiCDHA==
X-Received: from plbml16.prod.google.com ([2002:a17:903:34d0:b0:2e1:326b:da73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18e:b0:2e3:1bb4:6113
 with SMTP id d9443c01a7336-2e49b648c41mr42782405ad.26.1790979383748; Fri, 02
 Oct 2026 15:16:23 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:16:23 -0700
In-Reply-To: <25cdef9c45a1270dcad7e9c4140e56b6953eb27b.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <25cdef9c45a1270dcad7e9c4140e56b6953eb27b.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAtNhSQHDy_k0d_@google.com>
Subject: Re: [PATCH v5 5/9] KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> index 59ddc3757943..45a9d8b369b5 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -20,16 +20,29 @@
>  void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
>  {
>  	struct kvm_vm *vm;
> -	int i;
> +	struct kvm_vcpu *vcpu;
> +	int i, created = 0;
>  
>  	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
>  		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
>  
>  	vm = vm_create_barebones();
>  
> -	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
> -		/* This asserts that the vCPU was created. */
> -		__vm_vcpu_add(vm, i);
> +	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++) {
> +		vcpu = __vm_vcpu_try_add(vm, i);
> +		if (vcpu) {
> +			created++;
> +			continue;
> +		}

Oof.  I dislike this, to put it very mildly.  Is this the KVM_CAP_PPC_SMT thing
again, or something else?

Assuming it's KVM_CAP_PPC_SMT, is there really no way userspace can pre-probe the
"real" limit?  Or modify the test to enable KVM_CAP_PPC_SMT and do the proper
striding?  Eating -ENOMEM is all kinds of gross, and I really don't want to add
__vm_vcpu_try_add().
