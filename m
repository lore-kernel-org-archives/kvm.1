Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793657020;
	b=F+0xga9JDdaYHQsiPd3dbX+bCETGaeD4R8MMJymnJLx4JJMn3ljH5POAR+h1tC777qs+
	 z9FdPfy8LiV2jEVcG5jFdVPxw5h/Eaf3nMk8u5eH+W/F8NpHTM0+pGEfH2oo/nirAZiGx
	 kalyJs/77B8ioSG93Hok5x/eXyYwesGD7nZbki1f3wmwrKJZFHxiLAoVAomQ0gavYtSzy
	 0RJ4oyM7Xqc7g/bRKtCMLucjjsAT3Q3VEbpfVlOnKRN8aCEJbSrYW+auJDSoz1WqGjA4v
	 M7KbyEWdul4dXEhma6HRfrq5hdR0f+IKz9l1FEFSeGeDFH1sdORFN+59rA9290ZP4Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
	b=Z3sL7ItnHA1ULDD775lX3nKe/DGe851MfdlYMxRBxArDPsZees7I0l7f63XAsvXwr34F
	 7JmbG1PK9T3UWyPuPePSQG5URS8Ag26dP7OPIzHvWuCQ5L8Ee/a42WFT+ln7q0cTb9fFW
	 W5/I6MQYsI/3WY4tUaH+QZIJzn+m2uQ+0ahml45nwhYTzhHQbH5i6LSG4cZRoZj1h1iff
	 +YDh0DYGwiosRtmOQgzrezycYnVCEhpc5997XtrkRRy/Cci0BGElFCRRF0kFozOWq2W+7
	 e1m0Soz6SqkO6A69DivbvQXcXUnnZUNdHnmhe44vGTlePTtOMhj0WovgsKTKHUUBw9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eKIjyL9t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61E606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 22:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD61E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eKIjyL9t
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so3093a12.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 14:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793657018; cv=none;
        d=google.com; s=arc-20260327;
        b=Mmg142NcgWXk9fqAEtUgZS1rCdF2TA3ssATARFagSU7BtJbxaNhjZMFMgyHs8wIJI7
         G8ajLGZ/imEjgQlNP1OJ316ihRF0nyx744odgCI4vqhfWeRw073Moy5kNjmCHXTpOQ8j
         RPU47gqfIEEAWQJw2qT84fEwq/NJZsoZfkVHfX5aiYZ4HfjzpQ+ge67xQsY1XCuC6q2g
         Q/9J4vMpBJ+h1UOSR90EMNv+1XZ1hxRlNXjkaIUxsDfhbzxTKIgmdOO/idnDjnv+4gkb
         ufHGhi5N9Edbydcw9etju/3mmwL50FPQEYmszLSTSHn6DzFUwgWFWqwfhG/eixSE9g1g
         WJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
        fh=OAu4jDtxRdlpD9DC7Y68/Xswor39swnViLJwWokWQBc=;
        b=gqbJRtu9jw31NnCD+hqGpd8YI6F1MCUYMEzkuPFMGrDfglZ5fQaHqXPdxxYNqmpDjo
         T/VcdYwXK9zNpXOFHzLhD1chJlTkNqCNtDqcTCvIQEBbJC8EEqEKF/SXaoBYixyvfNJk
         H4hqdzZHvjErJBjejqxRU3eDdVWR4cOa5WaSQSfmb7K0RWkdmM3SDbL9f+JiYYUdqOgs
         4r1Qe/Pu2Rh5mgdnevNUCRV6I89MhUZpCHrmarL4ivVUvKGIY6uhzYw54pXg3AhiQkDu
         woAES0G9JDh8OPSJ4fylyaLxBRpYVyo7KuAcYi5Y4YqPMnpTYJJy2jvDhNIX2A7ha9a/
         yDOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793657018; x=1794261818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
        b=eKIjyL9tJJgkUM84z/AEYuKFdq2F89MguOg4/JVV770xf+cFqZnUOCaDRGoGs17CVK
         5LsH3tiIEzTZrwgawdNY/w/0rnY1/NNaBZUDy13IjciYwldh5bZov4HLLdr/VTUqxe50
         WIpzFdEtlxh7vlkRwrK2NbO/Dm//tNglyyJ7bzZgaGwUwgRRV5oMpsKtl9RA3inBJuG1
         AbSeB2f5on544dmM+ku70U8aTDcmI+TX80ZvCRJVCjx3w1EyLvs8wdqT9a2Ga9mYhwZm
         bHfRrTu2gSB5GCI46FK0Y22BQRXK4p7A8dFCIIWFFGB+uhp8r3AkeZwNcuTITCDriyYu
         3R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657018; x=1794261818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
        b=EFdhicXvz1Q3ihedgmFBiZoAgHZ8aadP3U/5/Kpx+39997aUwuMjAhT7mbPHCegSuI
         a0spNOnlHjSA7IakViJmaFK1HwA1xEsHycrIhTRuTbZDiGHLUus0NDgnqkrRj3+ctmJj
         37zGwKqbY6F863ASgLD/TipKsHGzSWJtN7z/JuzPNNmJKQbwWv3an9vxnMcvcnpDhWbA
         NwqW5nLd9Jg/K52St5evhGK6eO9VMyMFVQrb3AXp745wKYubGkcbpwvSL75VvBalP9Ny
         9m0crHsB+Z9+1nWkd+2Fkg3Mp1KLqXs7llHijrIrv+F5f0dqofyBUfbejmQ2tyBytqGy
         azAQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+dkbwhg55YH5R8DwiGut/O8NpaVrLR0DAhCKkhgwrPxEoXZkPlTm0lqwTTklNgOyehGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mg++H5TwtIpMOJca6aCxX6RPthdvZBJdZ3dUKei1W8M0yUyE8
	QpXRgOiXwMeh1b8PFE2xy60aCVf2B+4kbKDaeJgTY5F6yPIS673RIhj4xhqurGrtnp1k1hbujQL
	u1V4wK/dTNeNlQwXHrRxCJo/52DVTvxrah3Y165kc
X-Gm-Gg: AYBFou2dQW+VF7glRLRYzDvwqasu7UqY6Oayx6c6o7ZsqHsCTjI6TSCxkmXzyffiyl8
	I3LaDe+uBMRd2fXmQsCuZmLuK3VsuES5lU7ywyxCFJK6mao4S7OCT1HEq4cCunAXdRITHfmAGjd
	6ksAetpBegLv66WFW1LxeiynlQD+KuU5gNW6guQexgfOipiDqeiLrbvdzLvLjx6/s9ucaH2P8/f
	jp3jDwmQ9M6DBJ2v9Wtli3UOmeRGGzjL8Y1lXvXbkBBswJeYT1Lg4JxRAH1Ky7ryBc27GC1MBPs
	6QNxaWu+iCaQHec3xwUK/M+5EdtdQRZAhUmi+o80biswxmJf9wF5A8YajpOKjp5dhSbwCQWYhX7
	8Iyxx3+FZl9Q2xddO5kIJUBXuIM8qgUYeyFU3zA==
X-Received: by 2002:a05:6402:2750:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b53e7796a1mr3987a12.15.1793657017608; Mon, 02 Nov 2026
 14:03:37 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-3-seanjc@google.com>
In-Reply-To: <20261030212112.2598640-3-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 14:03:25 -0800
X-Gm-Features: AclHuK_pbmXvVHoGFvB48dY3tOJxijbO3CKujkx_4ml0ueoZxbb4z5FYesg9juM
Message-ID: <CALMp9eR-di2U5QZzDHh7CjnVg20ZnBcTBu0CKbbWh9QCxYiJdQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/23] KVM: nVMX: Don't force a full nested VM-Exit
 when destroying a vCPU
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 2:21=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> For all intents and purposes, revert commit b4b65b5642d6 ("KVM: x86: clea=
nup
> freeing of nested state") and go back to manually tearing down nested sta=
te
> when freeing a vCPU.
>
> When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
>
>   vmx_vcpu_free()
>   |-> nested_vmx_free_vcpu()
>       |-> vmx_leave_nested()
>           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
>               |-> nested_flush_cached_shadow_vmcs12()
>                   |-> kvm_write_guest_cached()
>                       |-> __copy_to_user(ghc->hva, ...)
>
> Accessing user memory via a memslot during VM destruction is broken, as
> there are no guarantees that current->mm =3D=3D kvm->mm when the VM is dy=
ing,
> because the last reference to the VM can be put from a different process
> than the original creating processes.
>
> And even if the original process does put the final reference, during
> process exit, do_exit() calls exit_mm() before closing file descriptors, =
so
> vCPU destruction runs with current->mm =3D=3D NULL on a borrowed lazy TLB
> active_mm.  If the borrowed address space has a writable mapping at the
> to-be-written userspace address, KVM will corrupt an unrelated task's
> memory since uaccess APIs, including __copy_to_user(), don't sanity check
> current->mm (and *can't* sanity perform KVM's current->mm =3D=3D kvm->mm =
check

s/sanity//

> since that is firmly a KVM-only concept).
>
> Furthermore, the shadow VMCS flaw is only the tip of the iceberg, as the
> MSR load/store lists mean that emulating a nested VM-Exit can read or wri=
te
> an arbitrary set of MSRs, e.g. if MSR_KVM_SYSTEM_TIME_NEW is in L1's MSR
> load list:
>
>       kvm_arch_vcpu_destroy()
>         kvmclock_reset() - takes pv_time off kvm->gpc_list
>         vmx_vcpu_free()
>           nested_vmx_free_vcpu()
>             vmx_leave_nested()
>               nested_vmx_vmexit()
>                 __nested_vmx_vmexit()
>                   load_vmcs12_host_state()
>                     nested_vmx_load_msr() - writes the MSRs that L1 liste=
d
>                   kvm_cpu_has_injectable_intr() - reads Xen's vcpu_info
>         kvm_xen_destroy_vcpu() - deactivates the vcpu_info cache
>
> processing the MSR write puts the "pv_time" cache back on kvm->gpc_list,
> and the next list_del() writes into the freed vCPU.  And as effectively
> pointed out by syzbot[*], attempting to fix each case individually is a
> losing game of whack-a-mole.
>
> Deliberately leave "nested_run_pending" as-is, because even though doing =
so
> creates potentitally inconsistent state, KVM should *never* consume said

s/potentitally/potentially/

> state while freeing a vCPU.  I.e. if leaving nested_run_pending set trips=
 a
> sanity check or bug, then that just means there's more fixing to be done.
>
> Open code only the "free vCPU" path, i.e. keep emulating a nested VM-Exit
> when forcing a vCPU out of L2 via vmx_leave_nested(), as there are a numb=
er
> of updates buried in the nested VM-Exit flow that are needed if the vCPU =
is
> going to run in L1, e.g. clearing pending exceptions and MTF traps, setti=
ng
> the TSC offset+scale information back to L1, and so on and so forth.  Not=
e,
> this means svm_leave_nested() is all but guaranteed to be buggy, but that=
's
> basically an open secret at this point and at least any bugs "only" break
> L1, i.e. don't corrupt host state as is the case for abusing nested VM-Ex=
it
> when freeing a vCPU.
>
> Link: https://lore.kernel.org/all/6ac0145f.34119e79.2f92f3.0003.GAE@googl=
e.com [*]
> Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
> Cc: stable@vger.kernel.org
> Co-developed-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
