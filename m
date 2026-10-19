Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BFD4E73CA
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412588; cv=pass; b=LnnMCrGpX8upRYTRcIXfBXRZKpCHaq3veiWul/Y3DJw3aslG7mJP+5L07t1GZPWfoMY6GcUDzgfhnW/X/HV+XhLeKCJnKPqHt6skZgSpaP/fWkB++cCN5Kv0WsDnW0wQpT5AchC8dgIdZ+01yOX4u2BkeOi89Xl8RBPt6tE5Baw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412588; c=relaxed/simple;
	bh=aS/u5QL0fraOagE3AaGbwApFV3BlaYX1A8x/PUaSsE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyP2AO/lR8K2UOkmNS912fS8rvsB5Uq0pxtqB+n3Vt5Vpye3jiouvgRmG4Q92/WfK3vkOrEbFYH9PUtTIMp+7A5zqqA7Pa5OImyYtriY8tKw4AcRDo7ZRdTDLF9ZwsPmmkBZkn+CWQg7hRYtLcrAlYbgnhjVByfKiIkJkYwvdTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1FDPNsK; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1FDPNsK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso14339845e9.3
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 05:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792412585; cv=none;
        d=google.com; s=arc-20260327;
        b=ExhjWw9OXWEHbnGmLnQ96km+EZITLfYZ9Ag9UbRqqryyWJsoog/IRi3JRGrn5OQMhm
         yon1CDv695a8wwOOBc1nXGrbDNgXGpn9vEaiy/aRlucJVOl1huY3FdbTbSaqY4wMxAAF
         XZNFp5rTbTNA9FlkwFN2Ct70GOwU3gXD9vIzzhD/C6RJkzRWOqohO6G1eYUuuYnC/A+7
         h4yggEB6fcSOjpSeG70u7oLEOWQm01QDoRJXeapuJMbch+JWSeyhyhCEUFoP1ER8Q+kI
         AEdRK5U4a2lFfu7tF11XTvzm1cPOeoz4hYGV8Kg/Zjrn7eN3NK3WpT23Mup+eOcjzWe6
         TTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VA0EaIAkAmiZf6ZT8orDontSqBSCrvS6TUwqvQWmRwY=;
        fh=tWB4PeUY36ijofTsavz8FyeTGUZB9BeOKx5H+dhQV30=;
        b=SzX3cdZ5wT/7mjy6DsGWzokO01OEFPIHABg8Jw5/iqs5kyb5EL/Jieqhr7qhcyupof
         Uzmf/oNQZGNXmrkW7NZANkUe0L/KzrDcwV56EG+sfsVRHgdqwcgIJX5Qod2PJ4t5o8Yz
         FyTCtDyvIzZhI72VA1aHlDRcIw0tV0XjYTOd8MqMWM6cXY4Wqc2S7Q9C/R36UW+p/OUK
         dMFDL2BbePqnoc/u1WOzncPH88+X6XFvvERCM5GwBrkE98CpKVG17T5HQEGTkn9VPlk0
         iEqEvooy4ncFJq2uzZcew0UCNuyp/4DlJ8k1eUdF7F9VcG7ecxkiTH1psRtlEYOou5xn
         7btw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792412585; x=1793017385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VA0EaIAkAmiZf6ZT8orDontSqBSCrvS6TUwqvQWmRwY=;
        b=Z1FDPNsK1NFwiroRHbL5ibduL7skch2E5OsaSux9VeMOTOEhXdXQXi7rpihigyc63K
         KLhvua+GLoNH1w6aJwyTDlWwDbkPWYOzHntruvKVsYN/M6DtcYSc7a2MlPpuOu1uoAae
         AqLGSvFe6+28CZhCAn/VMXiY6CyhjxfkyBpmUG9pqpu3Ij47mt47bxgeAdHSjQtrrMt8
         8itGAjWxi+kJ/LuiFXo2XOgqjt4Sb8lmb+jXuVCr2JKiDk4bDankF7ATC28lk9UhH2y/
         TA+LeBkCgubq4W/HVDk4rliSQGxW7dqd6DMelEfB5IuYmJbwCty5LTkLV9AqinEYTwH2
         qu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412585; x=1793017385;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VA0EaIAkAmiZf6ZT8orDontSqBSCrvS6TUwqvQWmRwY=;
        b=B2oSlDUmc2dH9Vq00LQXVzr/R++fk/8AMWbruviunGYvxCM7Cd3azlhhy1qUfZJTjC
         Z6cu/WBtUjrqOsDAwnmEjNzdCq/5gCcc2cwnYxgjO0EkqhBruH5SIFmnjzdPbU1rtK6x
         5d+JaXSfaYO7v7ttViuCivcf9AN/kmIneRpFRy2njVHGX4VkU5nsIk4LGz9WOuO2oi6N
         S3VyLZXCij4MhnMvg9R3BoOa2zEY0uWKwBeHysmE1BiEJkTEEpDZyXGD4RspwE5WjTMY
         w31rz0m3mo0L69ldgdKka/Kn89uZXQ0AnDc9LtkK8JLCyIPPCYx9Zh+O8JtWgVDR/FaG
         Dgdg==
X-Forwarded-Encrypted: i=1; AKwUvBwGgfKjW+1W9XB1szVXS2cVx377W7MvLv2Y0jmpSVPxIAjfFcoT2Es1HTlfTtn+JBfkLp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+T0yIyJloE1ssbBGqQlCc2n3LyEEO9l6wDSmKbUZEiWQlBucQ
	q0V0/NW+SBiUjmyfO+J4rr5JAPFr9T8gIHC40UmsXlTM38eCkfwxzobp5UUdggcyRuPvpJ55cw6
	zQ4fYw29XwuI2zcNbdf8+XJtFhISxikA=
X-Gm-Gg: AYBFou0C895X7R1JhUZHc4WkAcRvImU/dacTI95oKib57m6aBnzpiogCqBIJSbFDP/1
	wOIeu/+zZwWFC8t5wJkgZZ/8iMlxHrekPdO32tu35z4dosYIx43aky9gNSZf1ZwvsXbzOohZcxv
	6tkM76UffUY1ZvfirYZ6d20gIrdQcr/gdlcpFTRM5oVXnbtsc4Bslw/uosfV5scry4EMhRcnbBo
	YBx3KzHV1V1uEvFeb9a7JD0i4kBdWwAAkImuedRqUZMZRYaqoDVkPSPdyxi+etRsxxQVM2XrETX
	Wbk+Xq2/MKpcOstCc23Uqkx2ofDMrj0rR2BUoAfidKkUxA0H9wmPDoiOvJ0275eP
X-Received: by 2002:a05:600c:3e0a:b0:4a1:ef9d:1b68 with SMTP id
 5b1f17b1804b1-4a1ef9d1bcemr16345515e9.10.1792412584996; Mon, 19 Oct 2026
 05:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016234027.1002275-1-oliveriandrea@gmail.com> <kupbj8qt5pi.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
In-Reply-To: <kupbj8qt5pi.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
From: Andrea Oliveri <oliveriandrea@gmail.com>
Date: Mon, 19 Oct 2026 14:22:52 +0200
X-Gm-Features: AclHuK-8Uy5ANTpIKNhgJxOtHM4Dy6KGtcg5EkQBm7luqUiMMNutoR1waQmVy54
Message-ID: <CAN2kSaqJMAvYi6rw3YC46d=SzKBFopjdRkv7GQX8K=3w6DOL9g@mail.gmail.com>
Subject: Re: [PATCH] i386: Hyper-V nested sleep states enlightenment
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oh, I didn't see these two patches. They patch exact the same bug as mine.
Sorry, please retire mine and continue with the existing ones
(that patches also KVM hypercall side).
Sorry again

Andrea

Il giorno lun 19 ott 2026 alle ore 11:11 Vitaly Kuznetsov
<vkuznets@redhat.com> ha scritto:
>
> Andrea Oliveri <oliveriandrea@gmail.com> writes:
>
> > Hyper-V running nested on KVM (e.g. Windows with Virtualization-Based
> > Security) allows hibernation of its root partition only if the parent
> > hypervisor sets bit 20 of HV_CPUID_ENLIGHTMENT_INFO.EAX. KVM never sets
> > it, so such guests report "The hypervisor does not support hibernation".
> >
> > Add a "hv-nested-sleep" property that sets the bit. It is a hint
> > only and needs no KVM support. With it, Windows 11 26H2 with VBS,
> > HVCI and Credential Guard hibernates and resumes.
> >
> > The nested hypervisor uses the bit for one more thing, on resume:
> > instead of writing IA32_TSC itself, it issues hypercall 0x103 with the
> > TSC and the parent reference time saved at suspend, asking the parent
> > to restore its TSC. KVM returns HV_STATUS_INVALID_HYPERCALL_CODE;
> > the nested hypervisor ignores the status and already compensates the
> > TSC jump in software, so the guest clock stays correct.
> >
> > Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
>
> Please take a look at the competing proposal:
>
> QEMU:
> https://lore.kernel.org/qemu-devel/20261005194057.10910-1-hmushi@amazon.co.uk/
> KVM: https://lore.kernel.org/kvm/20261005192431.87317-4-hmushi@amazon.co.uk/
>
> > ---
> >  docs/system/i386/hyperv.rst    | 10 ++++++++++
> >  target/i386/cpu.c              |  1 +
> >  target/i386/cpu.h              |  1 +
> >  target/i386/kvm/hyperv-proto.h |  1 +
> >  target/i386/kvm/kvm.c          |  5 +++++
> >  5 files changed, 18 insertions(+)
> >
> > diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> > index e1babffb0f..4b37d5536b 100644
> > --- a/docs/system/i386/hyperv.rst
> > +++ b/docs/system/i386/hyperv.rst
> > @@ -187,6 +187,16 @@ Existing enlightenments
> >    Note: enabling this feature on old hardware (without APICv/AVIC support) may
> >    have negative effect on guest's performance.
> >
> > +``hv-nested-sleep``
> > +  Tells a guest that runs its own Hyper-V (Windows with Virtualization-Based
> > +  Security, or with the Hyper-V role) that sleep states are supported for a
> > +  nested hypervisor (CPUID 0x40000004.EAX bit 20). Without it, Hyper-V running
> > +  on top of KVM disables hibernation (S4) for its root partition: Windows
> > +  reports "The hypervisor does not support hibernation", and an S4 attempt
> > +  makes the nested hypervisor reset the machine. No KVM support is needed: the
> > +  bit is a hint only. On resume the nested hypervisor issues a hypercall that
> > +  KVM does not implement; the nested hypervisor ignores the failure.
> > +
> >  ``hv-no-nonarch-coresharing`` = on/off/auto
> >    This enlightenment tells guest OS that virtual processors will never share a
> >    physical core unless they are reported as sibling SMT threads. This information
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5da80ade70..9df628ed2a 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -10797,6 +10797,7 @@ static const Property x86_cpu_properties[] = {
> >                        HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
> >      DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
> >                              hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
> > +    DEFINE_PROP_BOOL("hv-nested-sleep", X86CPU, hyperv_nested_sleep, false),
> >  #ifdef CONFIG_SYNDBG
> >      DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
> >                        HYPERV_FEAT_SYNDBG, 0),
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index e7a88074c0..bff8b1d192 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2374,6 +2374,7 @@ struct ArchCPU {
> >      uint64_t hyperv_features;
> >      bool hyperv_passthrough;
> >      OnOffAuto hyperv_no_nonarch_cs;
> > +    bool hyperv_nested_sleep;
> >      uint32_t hyperv_vendor_id[3];
> >      uint32_t hyperv_interface_id[4];
> >      uint32_t hyperv_limits[3];
> > diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
> > index a9f056f2f3..df6ce6ae42 100644
> > --- a/target/i386/kvm/hyperv-proto.h
> > +++ b/target/i386/kvm/hyperv-proto.h
> > @@ -81,6 +81,7 @@
> >  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
> >  #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
> >  #define HV_NO_NONARCH_CORESHARING           (1u << 18)
> > +#define HV_NESTED_SLEEP_SUPPORTED           (1u << 20)
> >
> >  /*
> >   * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index da922f72d7..76f1a37ea5 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -1630,6 +1630,11 @@ static int hyperv_fill_cpuids(CPUState *cs,
> >              HV_NO_NONARCH_CORESHARING;
> >      }
> >
> > +    /* Only a hint for a nested Hyper-V: no KVM support is needed */
> > +    if (cpu->hyperv_nested_sleep) {
> > +        c->eax |= HV_NESTED_SLEEP_SUPPORTED;
> > +    }
> > +
> >      c = &cpuid_ent[cpuid_i++];
> >      c->function = HV_CPUID_IMPLEMENT_LIMITS;
> >      c->eax = cpu->hv_max_vps;
>
> --
> Vitaly
>
