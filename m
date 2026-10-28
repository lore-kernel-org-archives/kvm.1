Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793147631;
	b=Cumk7v6wfpDWVDAe9icavMpK4qcAvEiyxD0J2ryJST0pTM4G22GBwAvQctNPOGB6JQsY
	 W/FaXZahmjX7gXI5C+bKQgRRfDll3nqaEbIHmZE6tp85Bj5pW7saK+CZemQLOM7k6wP89
	 6kZJvgU/5+S0pkCWtkgzaQwz+uR163xAYBuzCPLN4hudvrnuYEDdAqNLqiL+eorU7bh4o
	 5YJexHCc+brsISp0FqNjMeGq6Ip9Y4yL29myTp0y8n4GDyyWpI905y3n+5/pxGLVZ+tlo
	 rs/u+0MBi97DZEKIszZTx5iZkzyPdEi39SGvRhOc88q5JvwisOShzmf3ZTdKSXj8Nug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
	b=hbHQvD/LaPsU3G+2q4CBfd9DgJClSuORNXFW8qjap/k7SgL4y3iIhaHoY/5eio7zyOJR
	 2AI5PNqSRiwkscUtelW8erraKP/cL1icrEphSTCDv2bn27L8/SjgX6pULzZ6gG41PHh2j
	 s+QLRjSwfOVDJdTkd4sykZCY6lc+Y5SUc/JtumvdDnauewbj3jX9VhGC0+EpoQE+xJ/RY
	 Js+8EAvubG/tkYbcsieNGtQZBcLVLENqCZPcmijM26EU5ggS67Boz6Vw15zicQDgiLr4J
	 j6EMfDQgsmuWS8hHdeVpEMNnp8T1SU6hKLhZzZWNuo4I0OrHGrrsqhYjFVaMFwIePWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NCVmBnRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68199606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 00:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68199606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NCVmBnRi
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-7037daaa820so235951eaf.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793147630; cv=none;
        d=google.com; s=arc-20260327;
        b=o4SbWQX/fqtA7JJU7zgPSLPyoS+v9sCyjPhdaUDYVKo9MN08pcv0h7mPI0N62QY0CP
         4Z+yNYB97aZsVX5qy8XvOXD3QXE2bYLlpbkOU6Ol6jkvErCC6cKqF81w0jTa6kWLiW4V
         TQMS+3i/BkCMQXtE1CGwQ85IGqMgkONs9sbXSkNHyxgTw9LyQKN33JufbT/uhr/SBVQL
         gGYtbsx3RdZpEGhZdMluxddIwGRchyk2VjWsAIdWOCVP1DoUwQ1puoeVOdR3mOhBGlKY
         Y/v+MR66cYxWVueGRus9uGpnWBvprigUHQVKqxKZf+If/eY/JJwg1mOBXpdQm2p5+HDD
         NLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
        fh=GhpgM/7hUlsHeSjNgzh9HqymqPJaBvjs/vj3SnaLJ0o=;
        b=BQ901u/Ou1oWfI9rd/QQKkRp/UyOhW4ePItI2UETL/C63CcrQ5VnveGHhsthCyTqkk
         KDFwAnxkkJtWS5dLPCrydT2JyYb9tBg8RjR82Y76Nokjdu5ekfsCIs0/I1vf6Wjo4MKY
         kWY7Fc2YAK9/G+e5legL5s0tMyte9OUoXpXaGrvI9/R8xI+W6JfmV1s3PXUzZv3J1xA5
         don6z/IBhajlEg3NrwhzRZPyqeUTDkn7e7fzKHxRHJA97oimZpVn+knn1kV+41NF/TNw
         EJH6QQXH01yyJfBQN/+fxZfXh5Q1iJEPB70pjAStjRSXKvPghWYpxcHkdNnFnWrDLQTc
         I1GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793147630; x=1793752430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
        b=NCVmBnRidhrFFMllAhawcqRAN0tNuE5Q7tarJMvVaxg7V4QXgiwrDW7ZGHbRKAeZFR
         r/8oNNpNXs5fKJZBPM29sjLjJBylIKHa9TOn3UyF9icqHdswHuoG16TyN3pvengXOjp9
         BRaHP39CZHtVTsLQ1a/2kqQ8NgQ7xyjTqVOtp73NTzEiKw8FyYtLtn5KsAVqNesudUnW
         YojsNnjXeAOeLcAoGsIXOKiEi2uO5dm8wFKYm+ZnzD7Dvn76DpWYwy/deZlRH+Laa3wx
         iRJLDvKB0dSeD7a5yltu+j2cHcaw6u7Ize6NA6Hzh/SESMdQGbTwUzVnlVdw6wZk9Q1E
         AC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147630; x=1793752430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
        b=qf0RJkRv/Cuv8m99YPeyzGJNhbEKdcVVBMRJPOU7KkPj4DjM2XQC4ep/6GYII2LSZ7
         xSMvR72upNNVxxZeDHAga4/co3a1UpAt/qf0BLy8EBJhIbaITQGk6Ze0wbgZeIRQ638s
         iB00VF8VN7Kql3E+z3HFktLZNeG57eucaoFvAPfFCGSq89bYWH+0udlFQae3vl3EZfhF
         u+5QLCL1bXyZx8xCe+sMhEUQJh110/Cu3UScPjrVb0HHNGjOAu2N9uTvqpyS5B29gzVT
         wqNKOwYuspuXj2IrOLMoDX/fIFHF8yXr8wD4TLyKtmP6uz1mxRbN8G7h+ZCp1SkHOPpJ
         +4vg==
X-Forwarded-Encrypted: i=1; AKwUvBxhDewzf0x2AyqCzZraWnS6C5ykjipcx3fYva1Mavf8ALKDPSvAgSiMWI1IczSz0Dy7VXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCHNb6tzzkpMHWYdizP5lsMyA1TP+5WiDOnY0uedSCEPmRyH7P
	sd2IGzij+40/uXGl4/AwJv6zJhPqtiX16s956U7YzQnKr+4zrBCfLfVDJAw6AA5MWNd+z8Wmmqk
	ceFjKhMfpjePeSexxDbhQ1myfzdiWJdNffQNAkZIRN7u5AsPrJH+Gyv32k9c=
X-Gm-Gg: AYBFou2iX+GTvlYav45PxZJ/q4EI4u11U1wVG3dReVRI9pE3ltNQBj1j5uRbueZXyje
	TXgkF9FoUTU4wSUl1zcQy80nxkK4i0utFZFp0Ss89cd/cLSn6elKYwFSgPcw9Cbq5/qyK9VzQn0
	96pgD7l1J+InnS/0esPQKQC42fHbe1rHRPqA3KyoZ2KhWEsqJHnmq26VuYuaZhKZqw0y8+RIKcs
	vI0mmlM7uKu9i3XRyS6utxq4MqnfdT7jeOtX+lWzwppt2LWsf/Cai4mDT/P3tFq4MftLOj0DQtC
	cYNL3KoeAlb17fqwA8zQZA/kqxxqfcyHUbt+7pjRPEp+XIzv5F6Zfnl9vDUsa/AdZ4Xadt5DCl9
	he2GZ+PdFZp4gdb/Bwn2VQ6YPGbea5FwNJ/77ZWugFq7LdxSBFmvxnir2wSA057wgS7IK6cUDm4
	13K9gf65ozuk+Sy9TzHJqvbD8fbhhXbJ+uVGpaOtKIc4Rnnp5zctU9OzDYXI4J6fm6KNIgVLD28
	ycAozuN
X-Received: by 2002:a05:6820:2207:b0:70a:4053:52ec with SMTP id
 006d021491bc7-713eb0544damr493322eaf.4.1793147629845; Tue, 27 Oct 2026
 17:33:49 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-11-seanjc@google.com>
In-Reply-To: <20261027221209.1560865-11-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 17:33:10 -0700
X-Gm-Features: AclHuK-F0YzeAsS0pikjvH3kUnFLPGjUCM-xAT7i-6P6IT1kD4-v_r0V8PDPxPE
Message-ID: <CADrL8HXMT8zBoB8ec2LP1UQWf1qn8qx8rqixvVpcsuO+Sb4p3g@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] KVM: VMX: Explicility free vmcs01, not the
 current VMCS, in vCPU free paths
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:12=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Explicitly free vmcs01 instead of the currently loaded VMCS when freeing =
a
> vCPU, as relying on loaded_vmcs to point at vmcb01 is unnecessarily risky
> and confusing.  E.g. during vCPU creation, the error path relies on setti=
ng
> loaded_vmcs and obfuscates that it should be impossible for vmcb02 to be
> allocated, let alone active.  Similarly, if KVM were buggy and left vmcb0=
2
> as the current vCPU when freeing a vCPU, operating on loaded_vmcs would h=
it
> a use-after-free *and* leak vmcs01.
>
> Because KVM isn't buggy, no functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d433cd846ac4..2ef1f634e7ec 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7515,7 +7515,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
>                 vmx_destroy_pml_buffer(vcpu);
>         free_vpid(vmx->vpid);
>         nested_vmx_free_vcpu(vcpu);
> -       free_loaded_vmcs(vmx->loaded_vmcs);
> +       free_loaded_vmcs(&vmx->vmcs01);
>         free_page((unsigned long)vmx->ve_info);
>
>         if (vmx_can_use_ipiv(vcpu))
> @@ -7614,7 +7614,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
>         return 0;
>
>  free_vmcs:
> -       free_loaded_vmcs(vmx->loaded_vmcs);
> +       free_loaded_vmcs(&vmx->vmcs01);
>  free_pml:
>         vmx_destroy_pml_buffer(vcpu);
>  free_vpid:
> --
> 2.56.0.307.g5fe7bd680c-goog
>
