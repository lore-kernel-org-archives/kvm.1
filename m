Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792856986;
	b=w/l2vDaOyPkCf0bw3Fm3kWP/R97pO/FLCV62UH8lWvj74wkDKBjpjQRA7eajL76ypttY
	 HvG8eCL1yJoqogBmUZHVt87YHOMD9hgAEfINAGQG3ChCx81rkP8BU7kr2VHp439rCBTpg
	 SHuArRMb0gOITPFz+Fd8XVzCfsUyJa58WpvHGv9XGp84XfgfHoF/khDCjUl+x2S+4x5Z0
	 Za/B8ZsZuvPWiI+O81EywlRWUSIW1MkD9W4Op8/kI4WHv1CVXi4ZReu6+vaYnY/UV0bmb
	 pExJFguAroVTsz23CVflvkSvul0DKJ9s8PSdmD95nVrRsiT/rgUIfu8X6nYKXozCOxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MpLw8ffwGE5r6iP7GkLZl5t1aG7oKBWl7zUDcI7ixbU=;
	b=BUMw7b6vWw9xmMBR2aM8a0KWQ0NM+c2V+1lokBbVNfqQPX/fnDQv3WSCc8yJfYFhNzho
	 LQF0F9CcvEYDf4cf0oIoxsRBUSzo5+69CuToM2ARK9FUG3qoyipCZh64Ita2abW4e6ja7
	 NcQHjO/MH35Oy3CoOv7cDiME57S4Xg/K1xUr7kcYoVpF6t4BFVwxNqId5cYRrj9w9Y2N9
	 v7smT3tASNN/4xon+hBoS7yCmsuDS07zPvleDYb2qTy6cBTjuRUq5kf6Nbyui6WWd3wV4
	 WLzyX2R6HOqhAeDQ0jHUAwYdaLE0x80/NTqmPd8Pl7g1UFnlTL3A1CDv8ubucQ9gWHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=hU41R2zB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5B606A33A
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 15:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E5B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=hU41R2zB
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1537921f8f.0
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 08:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792856984; cv=none;
        d=google.com; s=arc-20260327;
        b=KjTxZoB0XZnMHfT2o/nHj6Wd63PYAqXudxn3gKAhUhD8eZBzRC0loZNWlfYzFjcKal
         sIA3NQwLR8UsiUUhgPYbcvhC+KgD1TpW84A4nHW+Q+blO7+9YUlEfL+nOC7Agrtk8Fb0
         K3SExSUKDzurdWK8YBuMiAju25pl5TzwAe++yA+ryrpFZkjTNVm3dZ9zq14d2Ciu398R
         I1ny4jgFOoYgqQSIaRd8LL4AMXL7sKEfLGd8XV8xEEZMBT1OOInFxLXen3A8OXvkkAGw
         DlFyxNom9VOi2G50chlhGFQOry+glKfx5O0/fa3z6DHhOwnz9SIFgJ9kuJpj9ocl8C6m
         Tw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpLw8ffwGE5r6iP7GkLZl5t1aG7oKBWl7zUDcI7ixbU=;
        fh=EN5kGkXDXwBsEmHIvyz6i5siAnIFBPabCOxiCho6pWc=;
        b=bP9BkYq+QKEwovBxnW5wS0ronyR4EAUzMALtCDUB6ioPOypqB+SIOvFJH3Js3kDysh
         PBgnvo6wpTWW1p0p6ywy8AVKzsFsUx8K+DfjuFqcK5o03lQCI+AMFMEdT/B24o4cdgbo
         zORbXnD+A3LbG8lw/4EwhQXoUQjwVfggDOdUpSTeTRwnyy7eVvTGAmSXqGAfw23f83OW
         Kh5I+asQNfNIe6ppS5A/OiRUKC6dZEkBj39EnvwIv/cqADLW11D3LekJOG/p6w4c3iZg
         hsxOeXXdg78/vCnRqFcl2n1e67BJlI8kum8ADxhlNrZaOHmLrfCRyS0RitlnJSLDZLbm
         RLwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792856984; x=1793461784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpLw8ffwGE5r6iP7GkLZl5t1aG7oKBWl7zUDcI7ixbU=;
        b=hU41R2zBZM4iCQu4aSRvGSrij/rzZmnywMtg7VcpxGUNWODNVANWCGPTSHMoUb+qty
         4xlGXquygG60IwtefYL2jQfitTB8e5XMuD8dNjb75vs//vSFGrGWyYZswyVi5NljWVel
         D2dtX0NBTSF3D5oFx63yS6RhEdroEOik6ppCNS/piAHfEwJEMLBeg9aq8QIjgXNzL2BG
         ehQGWoX/pL3Absq8/uiMOA9nRUkhr1Mqh+omwzf2f9SSL2OiN19BzAG4W2ovnJs6I+Fy
         aWs4Hp416sJBpLFFK64+hPQbkcVkTHMQ8UQ5Rosdp0dqB0MAgrxPFwMfum7vCer28Xkz
         tnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792856984; x=1793461784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpLw8ffwGE5r6iP7GkLZl5t1aG7oKBWl7zUDcI7ixbU=;
        b=vMxPnmIlpPg7M65n6RyBYu8zQ7l/e+NtzLB6kx+xxUP9e8w/NfyfplOKlATInm+AyL
         qFFuQrjdfjp43SAmLrgH3Qu73D7+vUU0O/w0GynNJKZksiejqwf2+MnXaSejBf8YOLtO
         LERZK/64C8DI0rr+utJs4ue4UAYz/O8x9L5ZCmQtFd2MysMPCayHYbHx4Km2NGW1uS3w
         vksqD8muJz9TFWXWbzW063e0Hlv1kxZGrsbePzEYyQdM/yTtqCLhrMpUSZysFlxAXd6s
         DQ2fHO3Ma19f22qU4djWzAUiSA3LY0vWo5yp19hVAi9S8vulxSmukG1rv6EBBAgjgP6W
         hoCA==
X-Forwarded-Encrypted: i=1; AKwUvBxeMq02o1/46E4BVpeGBpaaOXY1DBYTH6KwI/9I9rR1KG7NH4AaP0i218gLsJIjJJqhns8=@vger.kernel.org
X-Gm-Message-State: AFq9FYITa6eeaj+fdtYEIt/R65mJhWlmq5+8FJ9xI9hdPRXwpiw95/HA
	Bxe3VvIVCA7YSYiL0TC18gvKIKElGKg5bmWQMmdJqNxTeRayTdggTvC+ySjzjRgUcCM0JG56JW7
	jGr9IfRlg5ed+1ERsq0XWyjClHigNCRMyWQhN5lGGUA==
X-Gm-Gg: AYBFou3FbDgbhF7v6/UtJnz85ELRfCZK8OmHOGAIEGDy/f32EzR2vY0+C7in9RE+agY
	9msGQ67f7gKLuv0rZTntM5FyWYP0ObIlzKlZOMFZEE5qAGtxaV2yRfmtL3MjIhnlyucfVNINg2R
	jHM7mi9qNW++r3ey63UtbgV5eQVPSDSv9XkDB0k7YXGL2915yzArvyjNd4cuaFbhzcs9JLOnx/S
	rGa2Za2dLNf7V9+nKMY/Bhf2XUhp78IezkOqJb8/ATBWAm94h5UYKLKzjIMjqEj7MBJWFemEZC+
	/fJYwBinoOC49b83QM2gC6feboU4g5TgUEuV7It5bsdnqYFE0WZv0oTq9GIQE0bn5AP79dhWnGX
	aQDvFHAQlXRdx4warHFvb0za+RwSUg8dLcKOP23GrCAawn97/E/b8pxp5AL0iMH4uLKs8fT0wnw
	DYZ9S9XeNghAMj/fJcuwfhoKR0IctkM48lobw5qq4q3XC/B+msZiNR3cY=
X-Received: by 2002:a05:6000:2905:b0:48e:2a6c:153b with SMTP id
 ffacd0b85a97d-48e3eb912e7mr4110791f8f.35.1792856983094; Sat, 24 Oct 2026
 08:49:43 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn> <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com>
 <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn> <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com>
 <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn>
In-Reply-To: <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 24 Oct 2026 21:19:31 +0530
X-Gm-Features: AclHuK8dPnhV5N0WLUCo7WCIcHQkxUlghpct-iOYcXADe2akSebbMvp9jc0Ck00
Message-ID: <CAAhSdy3XDEGfFJJnHfx2Q0w+dG4FombF3Lj5O_V4wBpkyAYTNg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU
To: guoyaxing <guoyaxing@bosc.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	majiuyue@bosc.ac.cn, anzoso@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 2:36=E2=80=AFPM guoyaxing <guoyaxing@bosc.ac.cn> wr=
ote:
>
>
>
> =E5=9C=A8 2026/10/10 15:50, Anup Patel =E5=86=99=E9=81=93:
> > On Sat, Oct 10, 2026 at 4:12=E2=80=AFAM guoyaxing <guoyaxing@bosc.ac.cn=
> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2026/10/10 02:51, Anup Patel =E5=86=99=E9=81=93:
> >>> On Mon, Aug 17, 2026 at 12:25=E2=80=AFPM Yaxing Guo <guoyaxing@bosc.a=
c.cn> wrote:
> >>>>
> >>>> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs to=
 be
> >>>> local or remote. Under KVM that mask tracks guest CPUs, not the host=
 CPUs
> >>>> that previously backed a vCPU.
> >>>>
> >>>> This can miss stale VS-stage TLB entries when a vCPU migrates across=
 host
> >>>> CPUs. For example:
> >>>>
> >>>>     - vcpu0 runs on host CPU1 and fills a VS-stage TLB entry.
> >>>>     - vcpu0 migrates to host CPU0.
> >>>>     - the guest updates the mapping on vcpu0 and issues a local sfen=
ce.vma.
> >>>>     - later, the guest task runs on vcpu1 while vcpu1 is backed by h=
ost CPU1.
> >>>
> >>> When the vcpu0 is brought back to host CPU1, the kvm_riscv_local_tlb_=
sanitize()
> >>> will ensure TLB entries associated with Guest/VM are nuked.
> >>>
> >>> By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do HFENC=
E.GVMA
> >>> for the associated VMID because most RISC-V H-extension implemenation=
 will
> >>> tag VS-stage TLB entries with VMID and HFENCE.GVMA must remove both
> >>> G-stage and VS-stage TLB entries for given VMID.
> >>>
> >>> If your HW does not tag VS-stage TLB enteries with VMID then it buggy
> >>> / inefficient
> >>> so you have to set kvm_riscv_vsstage_tlb_no_gpa in
> >>> kvm_riscv_setup_vendor_features()
> >>> as work-around.
> >>>
> >>> NACK to this patch from myside.
> >>>
> >>> Regards,
> >>> Anup
> >>>
> >> Hi Anup,
> >>     Thanks for the review and clarification.
> >>
> >>     Regarding =E2=80=9CWhen the vcpu0 is brought back to host CPU1=E2=
=80=9D: the failure
> >> we hit is not caused by vcpu0 being brought back onto host CPU1. In ou=
r
> >> case, after vcpu0 has already migrated away, neither vCPU migrates
> >> again. The guest process is later scheduled inside the multi-vCPU gues=
t
> >> onto vcpu1, which is still running on host CPU1. So the stale TLB is
> >> re-hit without any further KVM vCPU migration, and
> >> kvm_riscv_local_tlb_sanitize() is not involved on that path.
> >>
> >>     My commit message was a bit too terse on this point. The concrete
> >> sequence we observed was described earlier in the RFC discussion:
> >>
> >>
> >> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-e8c49c2331e1@bosc.=
ac.cn/
> >>
> >>     In short, the issue is: because vcpu0 migrated away, cpu1 still ha=
s
> >> stale TLB entries while cpu0 has the new mapping. After that, neither
> >> vcpu migrated again, but the process was scheduled from vcpu0 to vcpu1
> >> (which is on cpu1), causing it to hit the stale TLB. Consider the
> >> following scenario:
> >>
> >>     1. vcpu0 and vcpu1 are both running on cpu1. At this point, vcpu0 =
is
> >> on cpu1, and a process on it reads a page, which gets cached in the TL=
B
> >> (let's call this the "stale TLB entry").
> >>
> >>     2. vcpu0 migrates to cpu0, and then the process (on vcpu0, now on
> >> cpu0) does a CoW (copy-on-write) and establishes a new mapping.
> >>
> >>     3. Neither vcpu0 nor vcpu1 migrates again. At this point, the proc=
ess
> >> gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads the
> >> same page, and hits the stale TLB entry.
> >
> > This cannot happen because in step#2 when mapping was updated the
> > Guest OS will do TLB flush for all its VCPUs which means vcpu1 on cpu0
> > will also receive TLB flush and the stale TLB will be removed. This mea=
ns
> > when process is moved back to vcpu1 on cpu0, HW will fetch updated
> > PTE and new TLB entry will be populated.
> >
>
> Hi Anup,
>
> Thanks for the follow-up. I may be missing something, so I wanted to
> double-check this against the guest TLB shootdown path.
>
> If I follow the Linux guest CoW path correctly, when the mapping is
> updated in step#2 it goes through:
>
>    wp_page_copy()
>      -> ptep_clear_flush()
>        -> flush_tlb_page()
>          -> __flush_tlb_range(mm, mm_cpumask(mm), ...)
>
> So the remote SFENCE.VMA appears to be targeted only at CPUs in
> mm_cpumask(mm), rather than at all VCPUs of the guest. mm_cpumask is
> updated in switch_mm()/set_mm() for guest CPUs that have actually run
> that mm.
>
> In our case, before the CoW the process had only ever run on vcpu0. From
> the guest's point of view it did not migrate: the host migration of
> vcpu0 from cpu1 to cpu0 is not visible to guest Linux, which only sees
> vCPUs. So at CoW time mm_cpumask still contains only vcpu0 (or at least
> does not contain vcpu1), and __flush_tlb_range() would not IPI vcpu1.
> The local SFENCE on vcpu0 would only cover host cpu0, where vcpu0 is
> currently running. The stale VS-stage TLB entry left on host cpu1 from
> when vcpu0 previously ran there would then remain.
>
> Later, still without any further vCPU migration, the process is
> scheduled inside the guest onto vcpu1, which remains on host cpu1, and
> can hit that stale entry.
>
> This also seems more likely when the ASID allocator is enabled, because
> set_mm_asid() does not always local_flush_tlb_all() on switch_mm(). So
> even the first time the process lands on vcpu1, a stale ASID-tagged
> entry on host cpu1 may still be present.
>
> In other words, I am not sure this case is covered by a full guest TLB
> flush to all VCPUs on the mapping update. Guest shootdown looks
> mm_cpumask-based, and host pCPU migration of a vCPU does not by itself
> add other vCPUs that never ran the mm into that mask.

This makes sense now considering ASID allocator in Guest Linux is global
and not local. In any case, KVM RISC-V must not assume that the Guest OS
has local ASID allocator hence the kvm_riscv_local_tlb_sanitize() must also
santize TLB for other VCPUs of the same Guest which can potentially run
on the previous host CPU where current VCPU ran.

Having said the above, there are multiple issues with the current patch:
1) The kvm_riscv_local_hfence_gvma_vmid_all() is sufficient for most
implementations to sanitize both G-stage and VS-stage TLB entries
because both G-stage and VS-stage TLB entries are generally tagged
with VMID. The kvm_riscv_vsstage_tlb_no_gpa work-around is for
implmentations which do not tag VS-stage TLB entries with VMID
and this patch remove this work-around.
2) The other VCPUs on the previous host CPU may be already running
and may still hit stale TLB entry before kvm_riscv_local_tlb_sanitize()
gets a chance to sanitize TLB on previous host CPU.
3) The per-CPU pointer in struct kvm_arch is racy because we
may have two VCPUs on same host CPU which are migrated to
other host CPUs. Instead, it is much simpler to have an atomic
cpumask in each VCPU where any part of KVM can mark a host
CPU in the cpumask of the VCPU to force TLB sanitization whenever
the VCPU runs on that particular host CPU.

How about the following change ?

diff --git a/arch/riscv/include/asm/kvm_host.h
b/arch/riscv/include/asm/kvm_host.h
index a30600579231..c975eee7240c 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -9,6 +9,7 @@
 #ifndef __RISCV_KVM_HOST_H__
 #define __RISCV_KVM_HOST_H__

+#include <linux/cpumask.h>
 #include <linux/types.h>
 #include <linux/kvm.h>
 #include <linux/kvm_types.h>
@@ -184,6 +185,9 @@ struct kvm_vcpu_arch {
     /* ISA feature bits (similar to MISA) */
     DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);

+    /* Sanitize TLB host CPU mask */
+    cpumask_t tlb_sanitize_mask;
+
     /* Vendor, Arch, and Implementation details */
     unsigned long mvendorid;
     unsigned long marchid;
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 2ae34632cdcb..b1387a00c8b0 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -207,11 +207,31 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vm=
id)

 void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
 {
-    unsigned long vmid;
+    struct kvm_vcpu *tvcpu;
+    unsigned long i, vmid;

-    if (!kvm_riscv_gstage_vmid_bits() ||
-        vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
-        return;
+    if (!cpumask_test_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask)) {
+        if (!kvm_riscv_gstage_vmid_bits() ||
+            vcpu->arch.last_exit_cpu =3D=3D vcpu->cpu)
+            return;
+    }
+
+    /*
+     * The VCPU might have left stale TLBs on the previous host CPU so
+     * mark previous host CPU in the tlb_sanitize_mask of other VCPUs.
+     */
+    if (vcpu->arch.last_exit_cpu > -1 && vcpu->arch.last_exit_cpu !=3D
vcpu->cpu) {
+        kvm_for_each_vcpu(i, tvcpu, vcpu->kvm) {
+            if (tvcpu =3D=3D vcpu)
+                continue;
+            cpumask_set_cpu(vcpu->arch.last_exit_cpu,
+                    &tvcpu->arch.tlb_sanitize_mask);
+            kvm_vcpu_kick(tvcpu);
+        }
+    }
+
+    /* Clear current host CPU from the tlb_sanitize_mask */
+    cpumask_clear_cpu(vcpu->cpu, &vcpu->arch.tlb_sanitize_mask);

     /*
      * On RISC-V platforms with hardware VMID support, we share same
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index dd786f758eb7..c00dc0b191dc 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -107,6 +107,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu
*vcpu, bool kvm_sbi_reset)

     vcpu->arch.last_exit_cpu =3D -1;

+    cpumask_clear(&vcpu->arch.tlb_sanitize_mask);
+
     kvm_riscv_vcpu_context_reset(vcpu, kvm_sbi_reset);

     kvm_riscv_vcpu_fp_reset(vcpu);

Regards,
Anup
