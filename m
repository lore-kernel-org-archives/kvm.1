Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB22D1936
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763339; cv=pass; b=PtgRiEnBF1KWAyu+v5+B3/VdeLr1EvV2+V1nix8dnnPu0GOGca3Y/825ljb8T0qJdNSIKbsk9IXWS1K4fOLHFBJOIw/9l+qqqpcINt76Tg+Py9Rs0zg0VEeOvFMBWDUR0vpDSdCQ/eUKyMxz122TfIIqOnX4MFIDYMSnAnrAgBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763339; c=relaxed/simple;
	bh=CqqW22RO3ZRqLUDSRy8f7yh1EqvrK6CgpS2J8cVHpqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnF21UBtpZAeMhpVvmhcZ0Gxv5lgYUoP2P1UxsXDbauxmDu7pmcEmIfoEmdrm8E2wNob48COJzgkY0SiH8i0gllSGIl+1rNcF+SEg+sKWTQ1La1gfpaYNUuHSI33MTtSrdiqnDZ2QtXMFXLqvo5DJyfwfdQ/8fLXpqUBw9uU24Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsnKQETc; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsnKQETc"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so13112a12.0
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 09:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763335; cv=none;
        d=google.com; s=arc-20240605;
        b=E5haCb8V839jTvBtDZGgmQyxviMTiCqMFbZpMxcxSJ8nz4Ct4pEm/ga3/fn3HanEXe
         Z74wvzPDbWaX1WZAdXi7F3gnG3zguvpTpBuszEq8JISwZIvImTSlOTa6MUqAE7Azusup
         Da+VY9Yas2h/gcJuPu1mUjRoxqq9bdQDbCo+Pa6Vq8kQSER7VvyH8PniKaqdYGHsJQFV
         lR8Y4y+EzHxvB8OmE4jxQJiK1phfrVBOaTn5whzTdffzuMEY8g64kaB573O1JqcZdbBS
         KuzP2JnYM6KSWEHnGheIVw8g5ltRTsYCxcvMITQx5CuRXkGuH7Nfz8SnNX1uX4xkJhs1
         3gPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SY4/5vAWWcaV9x0jV4cO7baDxpJaaDgGr6iFNkqEvuQ=;
        fh=iOpYfUfc+lQsLjfDp5qH5/QKPaakF47qpraLdu1WO50=;
        b=iGekvzBxDbbH/fLODaxJuLYqZRby/bO4XdTBnXn2A1ZmJpVFbuBz2vgNeEiRiNRqE0
         TxAY2t1fqNuimV+zNIfaHjgVr/w+KJmZxHqiUWrsaqKb3o+IAvjWq4SXKHqy9IVbwxS/
         qhtvUOR8sJ0RYHailtRxkZriDtK6QIyybML3trqknmwGszwaVGz+XS+UpNBBVHZxOosF
         oo0xdlbSGkQjxObSFhvz0NAhMqUxcYVzICvxT0R7ysMbOaCZ1Cl8Rzk3gmwbWX5k9ksI
         /DoTboNtA8wYyR6eSKhNU0H5mi9y5nEOJXp01+A37GkpHBURrYLMbfm6RcRHm/AiN3S2
         QLRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773763335; x=1774368135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY4/5vAWWcaV9x0jV4cO7baDxpJaaDgGr6iFNkqEvuQ=;
        b=MsnKQETcw3qKro5hwCDhoywmoAkFKeqa6Ir0NxILtQoh3sEe6M1IDctTtxvrzn9RbA
         VnIBeNtfj7rMVSafhLU60CmGjcMJrp0bSpMoo6JDDtZMnd6i86Gj5cKU7eeuJ6hwNGLV
         6CiI442hnbmbJVYt0g3KzJY37QenvPYGUcv87moJTBZx+mA8WENJTmQcSq34Ze9xoUIR
         PwbKR3l1umlCmsU6B5n16/2n0l0GGEAxH4/Cvb5P8tPuq9lzp3z/Z1JoPWWTraAfiZ78
         819B9K3dxiHh7ce6yKbcxo7sp26n6xAU9Wt2fSTaK2JEjRXr54Zp+HEUa7M+TcmQis5+
         k1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763335; x=1774368135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SY4/5vAWWcaV9x0jV4cO7baDxpJaaDgGr6iFNkqEvuQ=;
        b=HkODKh1S+U6KwiLKHtCoCnuIn6MOTD44HhXG1hSYaWpABpYUtzCUIvwnkYB8whvfu9
         fBCJOzf7aNTKcjb2QPbunKtJy5Sa+zm3x3zfVyDzI4EEa6J7HAWvMw8WPpwNOLkS791r
         r73RXFh71/yr8wOvnRldsterlQQl2rJwES58U2DgBTy4tFNauvFM8kcVZjqlvLLRYr5P
         pnoQYDgpxUF96Vp55Vvj0vb6gD8W6Oj4t6WUojtvfmczMAzpltvJ8rHyTom4Azh/779I
         +ktYmzIiX0oIksmwZodPWydhQyCyls/6z/8AOuKaEkOrXANlEI/lcxrQ0X42X4Af/21G
         uBGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5JZ+oXYKSHu/uoggvuJwyccOcTDK6gpeTC4FOdtAg6CRaY7HUaO+VRuB44GyhEEX9Hmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQWCAbd8XPFVBd7EoOprtH9o/6ZO9AJTenDadQh2ZBbJC2SEv
	VFq3FOC7Ez5o3NopToFGYsUJU+QVc+BtGipQcMYUwSDRaPqt6W8rPLAwRij6rC7TKaYZYPFbj7T
	U0A1Wri3/bH/y3Zz2RF86PZ8shgYx04hFHl6fsKry
X-Gm-Gg: ATEYQzyZA8hM/MAD3ZZhoEMXtrx5mlNKYpFNBCEhKVCYAn6YHi4vGCTmJppNiYUFATR
	I1IBLCQi4lLkPKhstpkhr22G9yyYKc7KCiC9cipq2nnrbxNWUk7bQuxZoavCBqjKKXyiEWTVG+g
	INk0GJ6pgOuSvIEHr0zhrJpU/rOv/1wxD568igOd3Fqss5k6/3rZEtsztkjGb/AE5YhvDh3VPKn
	juhzzql1TbRT1LEhOwbckK4xsVQgpL++IezJ+GbAmdI8Kz4NksNhXWO7SLFI3aXWqNT9lmbeDns
	7i1fDGEUaTuiDvM7bQ==
X-Received: by 2002:aa7:d691:0:b0:660:b029:3d4c with SMTP id
 4fb4d7f45d1cf-66713bea8f6mr51265a12.2.1773763334159; Tue, 17 Mar 2026
 09:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_VUswFkWiTYI0eD@do-x1carbon> <Z_aovIbwdKIIBMuq@google.com>
In-Reply-To: <Z_aovIbwdKIIBMuq@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 17 Mar 2026 09:02:02 -0700
X-Gm-Features: AaiRm52Qe_TIMFzvhlPR8tJPzof84bHGndhqcQdcQocpyA2EGQ2Rrcs0dQ9C98I
Message-ID: <CALMp9eRvB5Jqbs6aKMsPzKDJE7Pb0iUTsO9Ot1CB698px1GHcA@mail.gmail.com>
Subject: Re: kvm guests crash when running "perf kvm top"
To: Sean Christopherson <seanjc@google.com>
Cc: Seth Forshee <sforshee@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:05=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:

> Long story short, masking PEBS_ENABLE with the guest's value (in addition=
 to
> what perf allows) fixes the issue on my end.  Assuming testing goes well,=
 I'll
> post this as a proper patch.
>
> --
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cdb19e3ba3aa..1d01fb43a337 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4336,7 +4336,7 @@ static struct perf_guest_switch_msr *intel_guest_ge=
t_msrs(int *nr, void *data)
>         arr[pebs_enable] =3D (struct perf_guest_switch_msr){
>                 .msr =3D MSR_IA32_PEBS_ENABLE,
>                 .host =3D cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_ma=
sk,
> -               .guest =3D pebs_mask & ~cpuc->intel_ctrl_host_mask,
> +               .guest =3D pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_=
pmu->pebs_enable,
>         };
>
>         if (arr[pebs_enable].host) {

Because kvm_pmu->pebs_enable is optimistic, I think we also need to
swap these two modifications to guest PGC in the code below:

arr[global_ctrl].guest &=3D ~kvm_pmu->host_cross_mapped_mask;
/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
arr[global_ctrl].guest |=3D arr[pebs_enable].guest;


By the way, IA32_PEBS_ENABLE can be modified in NMI context by
handle_pmi_common(), so the host value returned from this function may
already be stale. We have seen cases where handle_pmi_common() clears
a bit in IA32_PEBS_ENABLE between here and the next VM-entry. VM-exit
restores the stale value with the bit set, and that bit persists
indefinitely. If the next perf event assigned to that PMC is not a
PEBS event, it magically becomes one. When an NMI arrives for PEBS
buffer overflow, perf refuses to claim it, because it doesn't think
any PEBS events are active. So, we get an "Uhhuh. NMI received for
unknown reason" message on the console. A flood of these is enough to
trigger the NMI watchdog and cause a panic.

I think we need a fixup after VM-exit to clear any IA32_PEBS_ENABLE
bits that were cleared by handle_pmi_common() between
intel_guest_get_msrs() and VM-entry, but I'm not sure what the best
API might be. Calling intel_guest_get_msrs() again seems too
heavyweight. Maybe KVM could ask perf nicely to just rewrite the MSR
with cpuc->pebs_enabled? Note that any erroneous IA32_PEBS_ENABLE bits
are dormant post VM-exit, since any PMCs throttled by
handle_pmi_common() will have their enable bits cleared in the
corresponding event selector.
