Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3927CCF0
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780637696; cv=pass; b=BkhtbaX3TVi59lTMK0CqtFc//v6fF1fuAa2aIqBezhKi8oRNcNCsYh8BMTz8+AQyHe7zJsFFlXt181XtuO/EJE7sNGzS6A3sVr7hUVIyMCd7P516QyY3DUyatHYgkxtDhH5ihJ+veJGvZCLJgFL4Y7Gdw7vSx1DCfw02VBbJzXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780637696; c=relaxed/simple;
	bh=GJas4J0aA0V4cel94iSgVO8GdOFu8QvZX6zxMLeVC0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcQQD9dKoRKu1NCWtjFwwsMLLzNwb98QnfBkdR8uurvMQ1hSsMxADvMvCOWOlmCHAZQkAmAoY9uwvxBL9zEuYdPg9zFdmNRU/hbG+DS79w2U5zCxp5bjB77vrna40K0PMwrmPGkCKpX6TKvFJhgwZ35X1RVCs0z4YLKFLQHggE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxG7KOmO; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxG7KOmO"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so4726a12.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 22:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780637694; cv=none;
        d=google.com; s=arc-20240605;
        b=LAjc2yRWaLHpKlYMuI/N5bd3XyR2jAL8wKo9N92JWRcVnWNU4jQlYfNQP6lDld7zrl
         WSOa9R+q8M5RhO6KETkLxml1vlS4HvJTfy1hTok0URfRQMXVSMKqXNxNkMRLcW4DL1Ta
         CfhUY8pc6an76wHz5gnVO1Z+JPd8BfhgRUt4yrupreYqGxyiq2ApgF1pFjDQtBELnrdK
         UMhu3Kpe+kFdBzb5KoSX6RpYnllLSzvhEe2H7iFPhoyF/+sIUreMAFORO3089PhOmxb4
         S5vK4gF5IEuczWxywSWsBVA279ZCcumvlTbWlqz72p3hFhZ6gpQgBDGVZLHt4AGaahPU
         xPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Up0lWmIuIgRDM+NyYjwdMkV4DaYubiQupw+dp3jtfeg=;
        fh=iBABKnjJg7ebu/rFM+XjUCh5GbamYkeenuWqDBKEGj0=;
        b=JuyTadUrmGt2qL+cBO6Zs42Le+pPZeJnTfTylGu4j4gq+2KBVBdvs4rTnMZbgKNAEK
         OyfOBbhtMoRDGcPZNXgci+/eeHpXgi1ff3p4iAF+0POlI6rZd5eszVUFOjOpDOC2RAp4
         +lVPutQrNcPosNAiIfz2Yajn2Ut9uBJJZBbgKrB7wv6LqxAgep/rYrNtqeIo4pYrKXNb
         SqJZpruBViaarToLSgx0riyTvfYfYYNNRRLsBanZ/FELhacioLccUl/n7+eLkepXCxUq
         ztCbyZZhCldB8uewlZUs0hGaRzSRWNaAzBTNeFZEOPdE448/K9RDvCNNHmYBNKv2xvm+
         ReSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780637694; x=1781242494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up0lWmIuIgRDM+NyYjwdMkV4DaYubiQupw+dp3jtfeg=;
        b=GxG7KOmO6QNkfFl5yhurD7bZd1c90MnP+FXWaurGHposWDilswJE6J/WFY7KhKi7e8
         bSaRPjfbXB0ugDTmcs3TNPNls0d8G20k2Agmt3b04rkWom/Y9uChs0t57siBgxqD4u/F
         /ATinHD8o2VkMzBxtejnbxiZctcsQupeEeRayUIMj1KfURZh08F91gNni9BEIx2LkAV3
         9OfjULOM4PAesMxtJB0CRWPYaI2SsdaKP0RAgLHluoDEZzMEPj/cPk2QxoWVMYdVNN3u
         2LtrbD8Qiq5XtnQUY1p/a3wjix+RAwL3vI8JVcdp/82Lsf5cdti3zu+ZZmecBgmzOqAP
         X/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780637694; x=1781242494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Up0lWmIuIgRDM+NyYjwdMkV4DaYubiQupw+dp3jtfeg=;
        b=YAPF2rK9jTvXGTXUPB2wwLD1PHiiF9jTkUT2qcAxJn0Vvo0nfrDQj96QbKf392KVkd
         15fFtV5gjSmsmUWnjjBuSbSojhu94nkSkuTRVqL5ycKIEA98TVUsRHVa3I7+I41qcDWj
         gj5TTytG0iXnPaV1Xgk0kviSJ9E+34eNWUdL7nGAg+XcNAmbUmzm7AzDN8qnm0DzkPK+
         I/f9tibdU9ejJsEEgwxYootV+QjE08dhEAakqFniFZSu34Ptwh8lgq19s8Jro4gUJTTc
         WEWRDwEcAwza5vQvhvux6tvSzGTsX8SLZQDVXre1PPh4KwUxvkVAfZkJNGycnYL6Tq4x
         7Ldg==
X-Forwarded-Encrypted: i=1; AFNElJ/hG+AJA88z/0MvRfmyV7UFj5JK5jMTzMj/nXXMZnQb3uVHScTT0sosdSOKH0a7lYcyQ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLLsmYThjGeWlaqbDx/8lmz3YvMfJbi40hYc2YfYZRWWejSik
	Up1/LVPnv5vXS389vjqvBUggql360ndUSNQM0ZLtI1sM6jXJTtKzX9bJsFk4D8jXGWU3sgzrzX1
	cBFRAioH/bL1vvZjZLT3N6bcH0JM7erAtkB5X+l9Y
X-Gm-Gg: Acq92OH+YibyZr9eosJxkn+U78egyNzK35Nzghs+Q5eQjhVMH57gKbkW+TgJ2vDmhbl
	mFKth4TJ+In2OYQ9RhgA3jkjW0pKfkWSLhm0pUonhuf0vHK6glyFNGinSLrSvx/lkdit7axiIPy
	guxkvwUun4P+75BXSE7Z2lRwaFTWkJxNtMqsl4ArlmG4D5KQLDlctTpInhyQgC7H7xX2O5wk+q6
	GB8MMihowEd/byxsYKI3Qe39L1mP2klDwX9pACoNc77/tZYYh5QwF4qEbCL8l2HrYfJO/LzfOfv
	x5nZ2+a3StqFuS2BUA==
X-Received: by 2002:a05:6402:52db:10b0:683:33ae:8689 with SMTP id
 4fb4d7f45d1cf-68fe8b4cf79mr15028a12.4.1780637693492; Thu, 04 Jun 2026
 22:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com> <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com> <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com> <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
 <aiI6xge3Ev3PCpUV@intel.com>
In-Reply-To: <aiI6xge3Ev3PCpUV@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 4 Jun 2026 22:34:40 -0700
X-Gm-Features: AVVi8Cc_XsirzXhA3BVV64P98iM8XWJ3MeaaFW09qF1uHgxQn2-46j9Z8b1Tww4
Message-ID: <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
To: Chao Gao <chao.gao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, mlevitsk@redhat.com, 
	xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chenyi.qiang@intel.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 7:56=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote:
>
> On Thu, Jun 04, 2026 at 02:59:45PM -0700, Jim Mattson wrote:
> >?
> >
> >On Thu, Jun 4, 2026 at 12:58=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >>
> >> On Wed, Jun 03, 2026, Jim Mattson wrote:
> >> > On Thu, May 14, 2026 at 11:35=E2=80=AFPM Chao Gao <chao.gao@intel.co=
m> wrote:
> >> > >
> >> > > >> EMR158. VMX-Preemption Timer May Expire Earlier With Certain La=
rge Timer Values
> >> > > >
> >> > > >I assume the same erratum applies to previous generations as well=
?
> >> > >
> >> > > Yes.
> >> >
> >> > This test still fails on our SKX, CLX, and ICX systems.
> >> >
> >> > Sean,
> >> >
> >> > Were you thinking of enforcing a cap on delta_tsc in vmx_set_hv_time=
r()?
> >>
> >> Heh, to be honest, I wasn't thinking of a whole lot of nothing.  Falli=
ng back to
> >> hrtimers does seem like the easiest solution.
> >
> >I think vmx_set_hv_timer() should return -EINVAL for values impacted
> >by this erratum. However, the only documented issue is for EMR, and we
> >have not observed the problem on EMR. That's unsettling.
>
> Could you clarify what tests you ran?

Just tools/testing/selftests/kvm/x86/apic_bus_clock_test.

It fails on SKX, CLX, and ICX. It passes on SPR,  EMR, and GMR.

> I am using the reproducer from Yuan:
> https://lore.kernel.org/kvm/20240708055559.rl4w5xfhj3uru6j2@yy-desk-7060/
>
> I write -1 to the VMX preemption timer, do VM-Enter, and have the guest
> execute VMCALL to force a VM-Exit. On VM-Exit, we read back the preemptio=
n
> timer. The delta should be very small; otherwise, the platform likely has=
 the
> same issue.
>
> I tested several platforms, including EMR. The results are consistent wit=
h the
> erratum, i.e., I observed premature VMX preemption-timer VM-Exits, and th=
e
> documented limit did not trigger premature VMX preemption-timer VM-Exits =
in my
> testing.
>
> >
> >Chao:
> >
> >1) Should we just assume that all Intel CPUs are affected?
>
> I think that is reasonable unless we have explicit evidence to exclude sp=
ecific
> parts.
>
> >
> >2) Is there any compelling reason not to simplify the limit to 2^25?
>
> We can use 2^25 as a conservative bound, but it is much lower than necess=
ary.
> The current bound comes from theoretical analysis and was validated on mu=
ltiple
> platforms.

Yes, but how often do guests program their local APIC timer to fire
more than 2^(25 + IA32_VMX_MISC[4:0]) cycles in the future?

> >
> >3) Is it just coincidence that 25 + IA32_VMX_MISC[4:0] (on EMR) =3D=3D 3=
2,
> >or should the limit be calculated as 32 - IA32_VMX_MISC[4:0]?
>
> My understanding is that hardware scales the preemption-timer value and
> converts it to a 32-bit core crystal clock counter, rather than directly
> using a 32-bit TSC delta. IA32_VMX_MISC[4:0] likely participates in that
> calculation.

That doesn't definitively answer my question. Let me try to rephrase it.

With respect to EMR, you wrote previously, "A mitigation for this
erratum is for software to program the VMX preemption timer for values
below 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0]."

My question is whether the exponent, 25, is a fixed value for all
CPUs, regardless of their IA32_VMX_MISC[4:0]. It sounds like you are
saying that the exponent may depend on IA32_VMX_MISC[4:0].
