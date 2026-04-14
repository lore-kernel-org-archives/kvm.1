Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889535F162
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202325; cv=pass; b=cKXZfvRU2kUpo9ThNgF/mrjws2uOsXfCUQKXBzHgZpQDDKmGXufDZh/k6LIX6BtyTkQGGlStyzi1eImZZQieHkAmlEUrMIQK8TlDJNyTNRDBCUw2asYawf1IjSflcPhN+IAgQOnHiEdisv+/Xx4SxNQOCK5GIyYENlbg0Naps6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202325; c=relaxed/simple;
	bh=0bMWbNNPknOMlnrZ9ePIa3JmJ4zSpsHKBv9BnylTqfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEhHoUA2ZGLLHtqx07dbSPnfjhDM9+bIdm9CX82GObKur5SqM4twEhfxkHXXObveMWtVeW6dJNA4CM0D4ybIYHMJHEmN4ufcZ4j/b8yNbVaOkGUks77KvQsO81aL0gauDDglpXj99ggqttXU8uFFcJ+Ip1bx5uLUoWdGbLBeT7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwbc9VEB; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwbc9VEB"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so11726a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 14:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776202322; cv=none;
        d=google.com; s=arc-20240605;
        b=dNmOubpSKMztPkMnhaJdm1bDcAIy2233IC2aoloWJc0/QISwrwuVDxI/sjJvbd293m
         49TTp8BLe87nFGq5F2DKJTqrZ5zntcY6a+4hrsUlle1Bm7oR7PV0EACsAIVRu9g9T/9/
         8QbhuH71bu6Of0SQQVQFzNorSvP93p8cSDeVb67AVMQFLAdCl3AvJ4785hgJw9de6O8B
         EfWpbSdRN+2rF9dnUWFfdz9559xqcoYt6q4MpJJ/w0B313cjnkO07evwBi1+69xb3YnE
         lXYqFl/LPFolMzFo/34jKeqJQbtraIFOQRk6C01txJHlQ5P0ztLBmgq1MBH64lfRfYBd
         c+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8c04rmjwJCz23olx6KFxvIUrFknICuWDtkhXScF2mj8=;
        fh=jxSl4FPDWY38E2qO6MELWm8fOr7BP+gob8faIacYTcM=;
        b=K1n17eDB368E6rOLl9KyNPkw7YnhAwk2oCbKu6nWuvNb5FlrmtmgCgwrEULrrOs+Wp
         m60GqaXcAnaDHGHGY605GAScPb5CvfMalRcZCLFvxw8J8JbAHnzvmV66R7L4U7qFrFry
         b7ywhjNhApfWaXt2VBD9CztTocrDQFwboCEc3ZjZ1AuEyMLaDIwz7cIcE7wh7gN1Ouoc
         XjkD02xQ54zKe4DLQlcsyNGW/8iDyNmyvWTd8n1F8NbwBVD8olgIG2zlzg2h8fpMdQEx
         gqMlBCRYxxjodV2fJqEkHd9J5sXGBOnT6vtzUOSMxxHNJ38NG1vYnwA7cGOvLEgMoldD
         Waww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776202322; x=1776807122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c04rmjwJCz23olx6KFxvIUrFknICuWDtkhXScF2mj8=;
        b=jwbc9VEBKCnomLMpeCxBRsw6NmouLBmlWuI5cSdVmx67mzKZp4aiM7bzagcizwZ88K
         NKN5VdYXTmu9Nclvc0ZloL6ylPvOjmT8/6ZhjDnu1FF7VWdKYeD8Mrb77+6uwryAC8c+
         g9qkuqRcWousstSvXSWd6nrocQKXXEqrx9JIGInZCghwEyY2DE5Wv9gANVmZ7yfOfMGG
         n01tCZ04X3F91tqkM1kqCebOOWinMy8+ChsFf8Kiop8cgHaa7QhDy8JjSrbF+vpKmKQp
         E3rN4JkR908NDE61fbTQ1dHRrqGYm9oa+vXkTZk7dyYqY0B+H3OOS+zLmvsGfNWwXZQL
         HJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202322; x=1776807122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8c04rmjwJCz23olx6KFxvIUrFknICuWDtkhXScF2mj8=;
        b=kn2ibOH0zJEdsCc4DoX6PGOfDhBwx5HluPlmXWI+uO3ZUvHX8FZSuTeSdmsykFzCFM
         JXnZqTJd4Tm/LafA+TeYQwXPGhI40t3efXSLQwWN14aWDkR0dyHp7ieY7jSoICq7tN/s
         ZSwC0gWhj4Brom+1g6hcbJ3xUBhxx28Y6lUX3peCUzt35+Tavo1HY1rgsKsGxr7rk+7R
         mkVp0F8IEsDnR0kfHpH1Mh3fbZw6jTh58b92otEMr8dOKZZXD0IXcPIzLcLwJ/TwHhqI
         4bEHUmIzyLW9AtV88/M18sC3hIItsFyP595tb5sowq42rrq+eHVSOAZPiYeK38zE8xFM
         0GHQ==
X-Forwarded-Encrypted: i=1; AFNElJ93GspmDbPVGIGpk5g/AUDAZ6OapdnNbBiW1LFdClA7m+74kVvvhNlnkBWoNwMBqdOOOnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMslRuYPGqCpVWDRQ/XV4BTLSA2qd2OGDXjvyDkKa60X1qnhkK
	0Rb5d5oG1+pLFYjvVdusIDyUwo8m4/duzPVJQjiT/xR0PintaifqR5l9gB7U5Vhp1czcU5/0qA9
	AxN0ZZsDL/ZQ2pOwHCJSkvfjzkCfwcUqDd4/Mf1GD
X-Gm-Gg: AeBDietcCJ8IluoStU3TCqYwmjAkSKbM/yDembBr6WwyUqZ43y4KugA30+a8DLtZXLM
	MONggteo7XK0GF+dNcp+JvdUuZc54Zk4kYuj+l5MLixqf3fImgzlHGsaSnNXg1Oyw284CZl+Z5a
	Z7zKSNd0/Db7Q96kM5Cd29wbMikq9ynr9y5MP6mmkFuYY0/MkqhhCi5+i5l5So8I/hc0Pn5gNrZ
	zERiFx924hPqIBY20e0UATrq5XFj0S6n8QcVgacZFX4pmQ3qO/cCqwSme9x1Z4XFlQJkfTjF38e
	KzTcycWndbQK3JwTZWI8Hy1verlg
X-Received: by 2002:aa7:c606:0:b0:66b:99df:42e2 with SMTP id
 4fb4d7f45d1cf-67229aa19e2mr13192a12.10.1776202321602; Tue, 14 Apr 2026
 14:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-3-seanjc@google.com>
In-Reply-To: <20260414191425.2697918-3-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Apr 2026 14:31:49 -0700
X-Gm-Features: AQROBzAC-9qtV_u0_YI9YPgxTE2VIB9LQd99hMrKGKTMLu_9aTuwTBwGQJttTtI
Message-ID: <CALMp9eRxd=-xotnr9rLYhHtVK6G5oGAbXByXgpt078G8mWQEqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:14=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit=
,
> insert DS_AREA and (conditionally) MSR_PEBS_DATA_CFG into the list if and
> only if PEBS will be active in the guest, i.e. only if a PEBS record may =
be
> generated while running the guest.  As shown by the !x86_pmu.pebs_ept pat=
h,
> it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabl=
ed
> counters are disabled via PERF_GLOBAL_CTRL.
>
> Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
> writes per MSR on each VMX transition, i.e. eliminates two/four pointless
> MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.
>
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation fo=
r extended PEBS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 41 ++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 002d809f82ef..20a153aa33cb 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5037,23 +5037,14 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
>                 return arr;
>         }
>
> +       /*
> +        * If the guest won't use PEBS or the CPU doesn't support PEBS in=
 the
> +        * guest, then there's nothing more to do as disabling PMCs via
> +        * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolati=
on.
> +        */
>         if (!kvm_pmu || !x86_pmu.pebs_ept)
>                 return arr;
>
> -       arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> -               .msr =3D MSR_IA32_DS_AREA,
> -               .host =3D (unsigned long)cpuc->ds,
> -               .guest =3D kvm_pmu->ds_area,
> -       };
> -
> -       if (x86_pmu.intel_cap.pebs_baseline) {
> -               arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> -                       .msr =3D MSR_PEBS_DATA_CFG,
> -                       .host =3D cpuc->active_pebs_data_cfg,
> -                       .guest =3D kvm_pmu->pebs_data_cfg,
> -               };
> -       }
> -
>         /*
>          * Disable counters where the guest PMC is different than the hos=
t PMC
>          * being used on behalf of the guest, as the PEBS record includes
> @@ -5065,6 +5056,28 @@ static struct perf_guest_switch_msr *intel_guest_g=
et_msrs(int *nr, void *data)
>         if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
>                 guest_pebs_mask =3D 0;
>
> +       /*
> +        * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS w=
ill be
> +        * active in the guest; if no records will be generated while the=
 guest
> +        * is running, then running with host values is safe (see above).
> +        */
> +       if (!guest_pebs_mask)
> +               return arr;

I think this has an unintended side effect. If DS_AREA and
PEBS_DATA_CFG were previously listed (because pebs_guest_mask was
previously non-zero), KVM will leave the stale entries in the MSR-load
lists.

KVM only clears MSR-load list entries for enumerated MSRs with
matching guest and host values.

> +       arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> +               .msr =3D MSR_IA32_DS_AREA,
> +               .host =3D (unsigned long)cpuc->ds,
> +               .guest =3D kvm_pmu->ds_area,
> +       };
> +
> +       if (x86_pmu.intel_cap.pebs_baseline) {
> +               arr[(*nr)++] =3D (struct perf_guest_switch_msr){
> +                       .msr =3D MSR_PEBS_DATA_CFG,
> +                       .host =3D cpuc->active_pebs_data_cfg,
> +                       .guest =3D kvm_pmu->pebs_data_cfg,
> +               };
> +       }
> +
>         /*
>          * Do NOT mess with PEBS_ENABLED.  As above, disabling counters v=
ia
>          * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABL=
ED,
> --
> 2.54.0.rc0.605.g598a273b03-goog
>
