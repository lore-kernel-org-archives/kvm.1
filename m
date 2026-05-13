Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1323A8462
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630514; cv=pass; b=c8kfNeri83eYdL8y6E1frd/ZjbIbtGUMLXzfP+RB3q/qKDXMw48LOwQ0HxYR4qZRermJu074zjP/qp5I+sGMec9tWBQvJmi2qab91Rl/GcnvRSL3fEQeXtz3V+vJg5uOwS4nkbX979Wuu5zShhfJf8KjtQX8t1s39IvS/OVgUIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630514; c=relaxed/simple;
	bh=qMKdGqilmcz5qihTkNBxTqADyLgVYl3rc6ho+d2v3Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVU0mdkdKDEuSBvsBYsfKYCsm0uwTLieTM8OvoW/yl0OQGPs4dhAvohNlHrysnnuQBaxzrLYbDQXoLTOQWD8Ty4ktYygTOZF9sukEzCNQiz8VH/gVlaIeM1Bm+O5pH4GYeR8MYki7tR2ORhVPSrmuGhSdI+jwmVqyFpFqnPht0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1pzZBwc; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1pzZBwc"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so65a12.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 17:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778630511; cv=none;
        d=google.com; s=arc-20240605;
        b=exX/GFG1MjeII9UkDmEbv7q2RRFUv36lXmhoAS+WNUjjiRURVdYCXOtRZYLU6olaR9
         uqFe91RUXV6zK8BOFmR66t5HC/l28EkhbHpe042h7+cNwTt5oD2zAOLjAzWwesnisBhj
         +Hi3KOvQ/I5mOnJzEOfVHNqtpyswVJfK9yg3LIByP/IsNqESuUGSmNmqic7VjteZBJom
         b+aqbHWZbfBs5F5sqXHKkRrn3Yxgu7o61G+D0n5sIpPCJq+SS3jASrk+h59DxZ5HMfhS
         PvPFQHk4+KBYqnMlbKlbg7/2woMarXJVE7HG4sjOSZVRFshvaa8X8TvnIk8/AMLc95kY
         /9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qj83ar8FROyd4UpksW8Uf6mDTQ1HhWBShADjwu1KUNI=;
        fh=/S5y0hNANTljZxAwSkua7GY09HCyCf4w+oj1dPO3+9E=;
        b=Kt8wEAp2kgmiRyX7gukynMSZ/LVXcEEx38bR/4JHdR/qLcGmxIbU2GBUJvoiUk5nUY
         6K71G62g7SyCrwnABfWhVfY1ZlSIqaT9q+rzrtwpjCQUgbkJZr8anopX22Z4oyXNlyiH
         w7vSsezGMDIausyHg3UjmnsWh0FoJQGHwjK2JYEznA1vPzlcrUpmFXiSLBzgEH5FUwRp
         LiON4aE6TIRylx6CD1OJqOHuzZSWzbSCbehT6/b8G6mscOr1zyKShLL/wfdb34T5iseM
         yh4IfUSk1rUZxC9Pgjj5A/Bd7s5poy9UWeZyEsVmeiOqBi2UZYGuvgAh2Bw4mLgfl7ae
         5gwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778630511; x=1779235311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj83ar8FROyd4UpksW8Uf6mDTQ1HhWBShADjwu1KUNI=;
        b=Q1pzZBwcnRwtMwGdFonLkxCEFYXIFEEFFfTtBo326yv0JJZlZrsnFWmK5sz0ZRDwvS
         qXk1wvDIjsoQ9g/KIR5fIU5VZISljmaBEZlwtH/EYzPXMLx9LuKMy4Q4Yh20myGW2ugY
         jNrcN2urMMPIlWO+DoMz7I50sk8bdWdei0l6j4Ez5vXUuDdFvX9UjdUDIU+V4zmFcZds
         gJNJ04U/cmtvYYH05vYpmROwlV3yf8zVnmZ7t/BrMTl2gohri1+5/cjj2Sd1AEUj+vpR
         Du3lsFRkc9jiW+XPU1UMNkUPuxRG3gFXudGuGOuSzWUP64FrbbeR/Bf6mG4EwJ2lBPp3
         oEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778630511; x=1779235311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj83ar8FROyd4UpksW8Uf6mDTQ1HhWBShADjwu1KUNI=;
        b=SGOCjKyRN1FM6/v19poTqyPOfxZSwkEhoQ7jRkjM+TthFsGwZYiyyg2mYek/lgnn3I
         JKvF8HQ1jVZnjUGieoQRrd0E4YuRXncH1vvrfOEQDJ9fNmxhgg96sbOrv2Pq3Sg0Yt43
         B5DKfHtYS+6A4LwQZdtwe0DoNvBY436xsyeOjUZpJnejqBeIEQEM1KUJ1Ks0am9G32Cl
         +FV52PWZKr05nTXmO+qn0ME8xr9QZI1ZFua1pUzWMRsDAYQlBVsyiAiX33/83uBg8ajf
         aM8qb3wjJIUl3hW9/6X1r+pLwLmmV2qkEKwSXJcCa3s69AdvAfLXUZe7Cq39x0Mq209+
         pDew==
X-Forwarded-Encrypted: i=1; AFNElJ/g/GQ3PfYUn9GxvxehSqxuFGeRjkq5RxUEdKFtA6vGf9p2gTDFywcFzbKfVB18RYyrjwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0qinJLgxeh/Zgx4778QYz9CRM4p/F5uhNN1GYzyW32vKgOa/
	6wIwT4aT0VAoEInGf1/64G6Z0lsmv9LbnSzFBnuGXsuWye3/icRwG5yqSssgNRZYZeeFZbWaWJQ
	DlsAK7NYg2Di54vxDphS9xBEERkKgvlb0aIXfprdX
X-Gm-Gg: Acq92OHhDLEPEnPTRAIL8vbc7yg3GrkN3z2ivwX6rnxiltKqzrqZqC/gDAorTlR+TZV
	XOA2FdHEQgi/Omy1Vr7RnbNp2BhFyWcFL7WUcrGOb1GeAR35ed9RoBfd3WQX3u56u88hDRj6drw
	YSm85qM4rOwFYeUeRAY/VE7OzR39ybie+BTx4/KchZN2ejnWcjL/BGvap56Ro173UTENH9x6jDP
	ZTUHFd2SPMTJq3YZUzkKRY2s3DDg46BsK5IwDFo8n/ZkAwh9fFCNtPX3Uwumtsq7Ks79PNOlfCR
	oK/yMCMgbIjKXWNksQ==
X-Received: by 2002:a05:6402:a554:10b0:682:a2f:a15c with SMTP id
 4fb4d7f45d1cf-6827c43e148mr11375a12.11.1778630511249; Tue, 12 May 2026
 17:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508170714.489136-1-jmattson@google.com> <20260508170714.489136-3-jmattson@google.com>
 <agOcw9ZIXALKrs_a@google.com>
In-Reply-To: <agOcw9ZIXALKrs_a@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 12 May 2026 17:01:37 -0700
X-Gm-Features: AVHnY4K1zWwWI-fOvthYzhbwGvy3QYQSftynu7259msj2-psFwWf8hTG26Yrm_U
Message-ID: <CALMp9eRKcNpLxVBEg8RF6tSqndRFpLW_Q-rcXazPR9HYFJcdag@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86: Virtualize AMD CPUID faulting
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:33=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> From: Sean Christopherson <seanjc@google.com>
> Date: Tue, 12 May 2026 14:20:47 -0700
> Subject: [PATCH 1/3] KVM: x86: Consolidate CPUID fault handling for emula=
tor
>  and interception logic
>
> Extract the logic for emulating CPUID faulting (where CPUID #GPs at CPL>0
> outside of SMM) into a dedicated helper and use the helper for both the
> full emulator and the intercepted-CPUID paths.
>
> Opportunistically drop kvm_require_cpl(), as kvm_require_cpl() was the on=
e
> and only user.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 -
>  arch/x86/kvm/cpuid.c            |  5 +++--
>  arch/x86/kvm/cpuid.h            |  8 ++++++++
>  arch/x86/kvm/emulate.c          |  6 +-----
>  arch/x86/kvm/kvm_emulate.h      |  1 +
>  arch/x86/kvm/x86.c              | 18 ++++++------------
>  6 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index c470e40a00aa..a9005c61619b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2285,7 +2285,6 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, u=
nsigned int nr,
>  void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *=
fault);
>  void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
>                                     struct x86_exception *fault);
> -bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
>  bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
>
>  static inline int __kvm_irq_line_state(unsigned long *irq_state,
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..1c95d1fa3ead 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -2161,9 +2161,10 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
>  {
>         u32 eax, ebx, ecx, edx;
>
> -       if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
> -           !kvm_require_cpl(vcpu, 0))
> +       if (!kvm_is_cpuid_allowed(vcpu)) {
> +               kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
>                 return 1;
> +       }

That's so much better!

Will you drop this in when applying, or should I send a V3?
