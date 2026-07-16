Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DF315D5D
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164512; cv=pass; b=ljCVviZuYbbySGukpnWbSUNuSRSKkbkQm9zOx8vX/lufmAAyPby2HZun1LEbVxl1GYhhAaHz8G4A4jR9j9hISZxMnMUFseRbUOkim3toBnwKK4otlHBeqLl1/uZ3sU7vajos/5LDvZjiwIzirT5v6tsjmRPfTRMlaAn4d+E5Okg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164512; c=relaxed/simple;
	bh=/w08hq3SNrl5unkntTUYaNNGFp//52vley7NTAQwYl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF7Gth/VrRq5rIKxhXMxCnSHCMlrMaPYEV8j3Afc/pkGYkR9HOXoVTxTVQS0I5zKoCu8Lkdkkxp765tv8sT8AlWTar3oI8L5+GN3VOU82bpPLAYQG4n6Z01Hno6KVqQtw5/O8eI2Ob7Iqs0Bs1wI3jWebSV1MbUo/UASYAYayKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxyM3mjy; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxyM3mjy"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15d47266baso344634166b.3
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 18:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784164509; cv=none;
        d=google.com; s=arc-20260327;
        b=rkGPl+3N1OMX2t255r2+O9hH1qkjiMTug7aDmLJWZl+3zBqs/46ql0MfJY2hkERGv+
         WoRWhKtZq8Ti3O9a7ggUlmlG5zY6dxBBln5JCMpD8Vus4wcdiw/CN3Lea9LWi0inoC21
         O/u1Z2ZhhqDQFqVjfBOacqH/CJACikxXjmkX5hVgH0aWG8Kp1kW8lgjz1yfltQ9eSsA2
         E2L4gtreLwJOajDeagM1aMrACZcQo+/eaKwdeZRlQq4Sde1G/z7O77w+yGcTySPQugoM
         TLfnw3dxwcV6059/t4uWTgL++Pn26mnT+YPu8rlVj6HsvIWPzXVTd6YiBZ6MC5w51sMc
         4rGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nmijb/FoQac3oqNaTElP2vCQkmzRzb8oAIAbdOn+42E=;
        fh=2lWtu/UArwhOepGEQj5PZ0U1yS/I07dZT8v/jY0jEVw=;
        b=kgjO4F69KhNlFD9eH3E992+PIcKnRbqe11LLGykgo95DAUACYVk1Hj7rVOxNLWjcts
         JADOBRfiRzpUL4mO/G924NlHmB1xflJ+MMwQoA5kcBTztlGdERLOS6aa038e3cagXjM5
         igUtT8+V0kwzyU41GYjldJ4WDq1/l6LajBhDZAQis8qnLU80+1pkp4jVUf7iAeF9gQLS
         G2shIaIcOiYRzSSj2NzjMtAJ/3xzIsbHjgwJrIw7pfySXBIl3MlLEbu+/Ji6bCBiQNYg
         rauy4kOnMyMspGd6SxRAmee7tgV9wduj964JGTl7zIsne+CgeJmQ+q9hRUge5dyzepBX
         1/Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784164509; x=1784769309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nmijb/FoQac3oqNaTElP2vCQkmzRzb8oAIAbdOn+42E=;
        b=nxyM3mjyq1i21s4fZoxA/h9KYK77reNxhfeuLuYekTzolymLm8CHEVOqgU1cMpz+NB
         o2c2p2KyI35Hj80PXEpLNl7UpThRCnL6dM2L4QUKTDn/NLBP6EsPwJYDnUF8mOE5jc93
         cZ9D+X9liH596xkavDV2d9ZW4MO7vfyrVOX6r+YWb0D27eBw/AE96rmvPPe4IVFfhw9P
         QAsTNfsQdRaGxgVikEIQVV5mUc8Sq16wCaLwFpNMu/pSxdAqjo8TiioKcaMqXuScW66z
         utjhJreyJaHg6SDjm7ywW1PqO8r7TZLAWCqZDtwhsVScYGzLjlI4IPryKrlv0Vdb3Teo
         nWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784164509; x=1784769309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmijb/FoQac3oqNaTElP2vCQkmzRzb8oAIAbdOn+42E=;
        b=BO/ePRb99GiMolDh7pLAInnLP7mDc4xxoOrRt1njgN6r5QlrlmatTxmDvRGm03e/93
         //JRzGaOIaJqwNZVD0NQWQbOLpoSF3BOwpx9V/XO8hkMSXzmzmGUD8Sx9uPG4q8Hrnsw
         Uv0ENEwWNpTOk0rtj5ZdFRBx/ATbdBMLhTn7jWhu5kU5TAHw5iwhAaHmZVN4cblfbGfZ
         IMKs9G9uJaihQ4rk6/bm0E6a8jT2mhmyLdEjdZFOYU2dEimMTw/dEYV4f/LAvBeb7Vsd
         mRqFWZuaUYAGC+814YqpyRaabdU5DmXHW3w95XvpKIyWF3YqNu59ScliHnan00TzbJ1n
         BlVw==
X-Gm-Message-State: AOJu0YzbFRghkuvM+rgF7gVOs7klNuN8zNxhGOxyr0EZ1sO7cZjofzY3
	bKiGGO/Xr4YaG6IkXmbPXNmV9JnaFH3ywWaxqhAtGnr0ycSwpaUEJLZpX8ebODsPgzf19YWYOkD
	rPNOand6ZEt1ekBs8b1DYjGIzfXwz4c8/HrtB9RaY
X-Gm-Gg: AfdE7cn1wb30FgS9wOL8xKIbB+WD7I9GWWTtpYFJkX2Csy6F1QfzlR8l198AR7PJSpP
	yJTZ4zaKfiCiTj82y0wej9Sl/rsnj870Z3Te1rHfiC5Cp0wTzKCv1OAaq93c1Io669pwtoFc94t
	TQSbYwIlQ+Diu9hy+oGQc15fKUrGxf0H1TdhRPpfVVAlOiILGi2ey+DOR0iI9wuFu433RuX1TKw
	DRKT5tKEwtIyxqikip4eqLNcmHSKhjrf2S7ovGvjKG+jomR96HxqD6fIu4S6GFzoKWzwgzKhAL+
	3k1Im0+tookTd3bD5W0ZeXDmXVVaa7qzrf0zSULCfrENVZo4
X-Received: by 2002:a17:907:6d20:b0:c12:34f0:f7b8 with SMTP id
 a640c23a62f3a-c161ea6be7dmr962592766b.55.1784164508299; Wed, 15 Jul 2026
 18:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715234234.15382-2-venkateshs@chromium.org>
In-Reply-To: <20260715234234.15382-2-venkateshs@chromium.org>
From: James Houghton <jthoughton@google.com>
Date: Wed, 15 Jul 2026 18:14:30 -0700
X-Gm-Features: AUfX_mxZPkookJAlOtrSYHlulzoxjnu5C4iZKL0oTqb1lOaPZctrjx0v-nWFr7I
Message-ID: <CADrL8HX-wfbjF=huA_kopNEbq63E3yhO6_9WfrcfH5EgJYAk1w@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Only reset TSC Deadline Timer in
 apic_timer_expired on KVM_RUN
To: Venkatesh Srinivas <venkateshs@chromium.org>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Venkatesh,

On Wed, Jul 15, 2026 at 4:42=E2=80=AFPM Venkatesh Srinivas
<venkateshs@chromium.org> wrote:
>
> Fixes a lost timer interrupt issue if:
> 1) We are on an Intel platform w/ a VMX preemption timer && APICv
> 2) A VMM calls KVM_GET_LAPIC before KVM_GET_MSRS to save vCPU state
> 3) The thread executing the two calls migrates CPUs between the two calls

I think the paragraph above should be rephrased, something like this:

"On Intel platforms with a VMX preemption timer and APICv, if a VMM
calls KVM_GET_LAPIC before KVM_GET_MSRS to save the vCPU state, it is
possible to lose a pending timer interrupt.

If the thread running these ioctls is migrated to another core after
calling KVM_GET_LAPIC but before KVM_GET_MSRS and the guest is using
their LAPIC timer in TSC-deadline mode, not only does the save LAPIC
state not carry the pending interrupt, the TSCDEADLINE MSR will be
zeroed."

Sean doesn't like pronouns (like "we"); he'll probably have similar
style feedback.

>
> After migration across CPUs, KVM_GET_MSRS calls vcpu_load, posting the
> interrupt and clearing the MSR:
> vcpu_load() ->
>   kvm_arch_vcpu_load() ->
>     kvm_lapic_restart_hv_timer() ->
>       start_hv_timer() ->
>         apic_timer_expired() ->
>           kvm_apic_inject_pending_timer_irqs()
>             . post interrupt into the LAPIC state
>             . clear IA32_TSCDEADLINE
>
> The saved LAPIC state will be missing the pending interrupt and the saved
> MSR will be zero. Oops.
>
> Fix by only posting an interrupt when we're attempting to enter the guest
> (vcpu->wants_to_run =3D=3D true), not for vcpu_load from other paths.
>
> Assisted-by: gemini:gemini-3.1-pro-preview
> Debugged-by: David Matlack <dmatlack@google.com>
> Debugged-by: Sean Christopherson <seanjc@google.com>
> Debugged-by: Jim Mattson <jmattson@google.com>
> Debugged-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>

You have included cc:stable (on the CC line in this email); could you
include it here in the patch as well?

Also, what is the appropriate Fixes?

> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 6f30bbdddb5a..74dfdbab4ab9 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2052,7 +2052,7 @@ static void apic_timer_expired(struct kvm_lapic *ap=
ic, bool from_timer_fn)
>         if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
>                 ktimer->expired_tscdeadline =3D ktimer->tscdeadline;
>
> -       if (!from_timer_fn && apic->apicv_active) {
> +       if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
>                 WARN_ON(kvm_get_running_vcpu() !=3D vcpu);
>                 kvm_apic_inject_pending_timer_irqs(apic);
>                 return;
> --

As far as this change goes, it makes sense to me.

Reviewed-by: James Houghton <jthoughton@google.com>

Thanks!
