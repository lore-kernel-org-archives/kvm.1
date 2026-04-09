Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90033EAEC
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768811; cv=pass; b=iWHFgF1ZLfwgL+Y2mYns7qH1Y5sEKtjslDAd3bqqOKZkZIFl937qDSj172te3kIPh1QrVVxvkhdIU8zL4UGnuodBdhNQ/Fi3e/c2beyEs7jLsUyZ+/4SekAWdWK6cs6zU25LlUNhJLf4wWh8DgoPOlsbiXjdY+HDYrclNcPXJ0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768811; c=relaxed/simple;
	bh=Jh9WA8x2awad3lmAqYVpxS5VOwXt/AnG9yTjUz42fhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3hMA8zyZKsBN1e5eYVrROkDcxEKUWk2GLG7QayPt9gMxQ4nmxvG8WrbX3tK8GM70Bjv1Gwvu73IQbZDVKfR5sJF72MiZLqFaIktiUedv+hJo7s7+dKEBKCJPpMWKyFW3qJ69NCcQ7tBcgo0V9LX8lUt3UhuiYpxgqo5J7Fvvko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5q5gE5X; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5q5gE5X"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso17197a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 14:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775768809; cv=none;
        d=google.com; s=arc-20240605;
        b=e63Jay9DEW4N0wYuzROPAmb8hZ1sU5H1PV/HcCYqkr5Sl6Skhevom5vDVOP8SmwX/y
         91AJp+ZOBsOCUuFIgdLKJrP+LPTMdj7KMaH4G3wT9L92zTJZZ0/RBo+zKAu2gK2b0927
         cXwUXkQpNxgjkoRkhfRVPDmUysg3zLgVtHAQVwP15BJGe3m6MsOot1DU2Sbr9q7+Phex
         eO24QoUObwx3lRTBNlamfXaUvTIoT2OZnJ2KwPaymaBGFZI+SgQsxKWzrLH1OWVp9lgL
         NfDWVW47W5OIyBQOJ5fPCKWFd3qrAbmAGmhS/A2016DzsHY/3vNZ8LcF2W7GyRPUwyiy
         6fJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6Io+TbgEInBUXr2ZZvVAjzS0NzLS5bRjm9qTjcDPeU=;
        fh=g26ah0DZ9GGtzG6fkjJujMqrGBCvQ7DFqTFclwoU4do=;
        b=JCAsZcPgXRT6YtXhSfV/vMwzpSPbm7oSndFyl2Aa8wl+hc9sIfeBLefqRycDdVrbDM
         2BG7rpcrOREREp0uV20r3gqTCCAPOrOpF3raky7vmNE1eUCByNIFDY1gjH/NgK/fXX/Y
         uJ3BhwK77L/KPwMjNwvQlatfarfK/3zuuIKQPRUnXzG7PjrSgAGKbghGjcWlh0JR0qBR
         7RAlseu3twGLWaf0Yhg3pi/EQLlWRdce8mO03g+qSd45cXrKygd+tc5i01elYbIDhyu2
         7tSiU5Vm91Bbgg7XkB5uC+yGurQDKM18cA7MJkpMUQEqHPifBqs1Edi5vgF4s0U5m/PR
         8oXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775768809; x=1776373609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6Io+TbgEInBUXr2ZZvVAjzS0NzLS5bRjm9qTjcDPeU=;
        b=N5q5gE5XZJ2yYNIdmYor+kWbrOcd8iEX7Ctpi0F+2Md0qQnWSA1Afc6qFcTrN8C3bQ
         TF5cjdXy1H10yJhuvM49JQQD5ggH4ThQr6ROst0afwNDa5tk9hVE7bQ6YOPqls8O+yG6
         WcmtBfFUXP71se+/R5rvKaRbYDDP3wr8/XvgsNzrzIQUQrD2vtEPUdmJwD8J4ynqSZ/Z
         z28bPGk2F2WEJwUHoPvrl3Bme3bX1jvtfexjmhpFhE1j8zWe0BEO8AvBLugxl+CLDQ5N
         hHOa02rBVavtPIT1buOtLr7Lb297cN9XYXi1s4jDVHWnIv0whud0PZFG+TfBiAAJhZBf
         KpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775768809; x=1776373609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6Io+TbgEInBUXr2ZZvVAjzS0NzLS5bRjm9qTjcDPeU=;
        b=ZczQ28Ol2JU7gx5ikPXajEs8ez3+ZumnfQ9ikS/5ag4VYfSjsyONvQ0JkTKw1DnJbt
         KbHo5qJ9p/TO3nbf8fOUq9ZmmEVReEGybFhkhcchzjJjSWiPN9WVQo68nzBCq4kqjMpH
         bopVdTqUs3Xr8+g4yq1RoMwi0bs1kARYX/lMEFXX4RRKBxXe/6R7Ks4RTYue4o9oUUZj
         Q7XKJQ5AqLIj4hc4Xm3hs0NtQ6cc3gnVM7tS+wAcfTPq9h9QP/FuuMltNA82KhjyfF4i
         E69NZgzoIGsCZ3wDRMCxDsi52p81wMX3dHmOGEmb72HTqRq6dj3g/niRS6YBjyAuqVnE
         18+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEMlmEUhLTuWh0Q/Lp4dUF0m6yROWky/Q+r+4TY22tG/Xj8dEgmZtK0e56CNlHXey6C7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMkuN4+lCSCTueWRtsxrp2Chy0mA0ISaF7Fp8egbPv6uAXcUyz
	e/5fwIw//bHB22MvoNG0xQtm6cZ3b5UfpZIe5tuqbxoAXODl0LaIVohp314kGrqNLUmDS+6PwiU
	cTrJvwmxia4TEHA4Pm4oIc0m/S2vejTb/xXOmdiZk
X-Gm-Gg: AeBDievV0cdHVnCAticiGg8y/BUFdlFP8OT+1ytJcYp9yFCnO4OHtzSbVhhZOjb6olG
	OkHPCXLvlCASQjtuGBPFzWfdmQ09ZeomvY5buAYf1P90TE67fNMlNiRGG22X7t2Kn0EgDS9Duhq
	6kcInOooQTL/6ADN48PPyrEGy4MIK6qBr+X/XdAAp7pycdWuq/UQNVxS5jtonEwbk1QOGPTP/gG
	xPVaNeHXagDDuz5363AzNyNGC6ykFMuULCFe2kic4yY2xe3nKUCFq7uduWcJO+rjc1H2tx/FpxI
	EabcrMAmxrzEveDcxg==
X-Received: by 2002:a05:6402:26cc:b0:664:eadc:7262 with SMTP id
 4fb4d7f45d1cf-6701e2ad1e6mr79997a12.13.1775768808382; Thu, 09 Apr 2026
 14:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk> <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk> <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
 <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com> <CALMp9eRfNsghM_RnDXOs=SJYObfPa5A1aOVDZno_zJ=XotfmRw@mail.gmail.com>
 <410df9f6-69ec-483f-9009-0a9b8c9162a9@intel.com>
In-Reply-To: <410df9f6-69ec-483f-9009-0a9b8c9162a9@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Apr 2026 14:06:36 -0700
X-Gm-Features: AQROBzDpN1eCOiQJSVX_bZO_GJCCAd5QpgFXMhi42CoW97OvabZocFA88ATO2hY
Message-ID: <CALMp9eQx3H+n3V3dQh+ZafQZ6uNBjSYk8tZsvG6ffcY43YTrnQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 1:36=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 4/7/26 17:47, Jim Mattson wrote:
> > On Tue, Apr 7, 2026 at 4:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> >> On 4/7/26 16:27, Jim Mattson wrote:
> >>> What is your proposed BHI_DIS_S override mechanism, then?
> >> Let me make sure I get this right. The desire is to:
> >>
> >> 1. Have hypervisors lie to guests about the CPU they are running on (f=
or
> >>    the benefit of large/diverse migration pools)
> >> 2. Have guests be allowed to boot with BHI_DIS_S for performance
> >> 3. Have apps in those guests that care about security to opt back in t=
o
> >>    BHI_DIS_S for themselves?
> > I just want guests on heterogeneous migration pools to properly
> > protect themselves from native BHI when running on host kernels at
> > least as far back as Linux v6.6.
> >
> > To that end, I would be satisfied with using the longer BHB clearing
> > sequence when HYPERVISOR is true and BHI_CTRL is false.
>
> If the guests can't get mitigation information from model/family because
> the hypervisor is lying (or may lie), then it's on the hypervisor to
> figure it out.
>
> I'm not sure we want to just assume that all hypervisors are going to
> lie all the time about this.

Without any information, that is exactly what we must assume. There is
precedent for this.

In vulnerable_to_its():

        /*
         * If a VMM did not expose ITS_NO, assume that a guest could
         * be running on a vulnerable hardware or may migrate to such
         * hardware.
         */
        if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
                return true;


In cpu_set_bug_bits():

        /*
         * Intel parts with eIBRS are vulnerable to BHI attacks. Parts with
         * BHI_NO still need to use the BHI mitigation to prevent Intra-mod=
e
         * attacks.  When virtualized, eIBRS could be hidden, assume vulner=
able.
         */
        if (!cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
            (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
             boot_cpu_has(X86_FEATURE_HYPERVISOR)))
                setup_force_cpu_bug(X86_BUG_BHI);

...and...

        if (c->x86_vendor =3D=3D X86_VENDOR_AMD) {
                if (!cpu_has(c, X86_FEATURE_TSA_SQ_NO) ||
                    !cpu_has(c, X86_FEATURE_TSA_L1_NO)) {
                        if (cpu_matches(cpu_vuln_blacklist, TSA) ||
                            /* Enable bug on Zen guests to allow for
live migration. */
                            (cpu_has(c, X86_FEATURE_HYPERVISOR) &&
cpu_has(c, X86_FEATURE_ZEN)))
                                setup_force_cpu_bug(X86_BUG_TSA);
                }
        }


In check_null_seg_clears_base():

        /*
         * CPUID bit above wasn't set. If this kernel is still running
         * as a HV guest, then the HV has decided not to advertize
         * that CPUID bit for whatever reason. For example, one
         * member of the migration pool might be vulnerable. Which
         * means, the bug is present: set the BUG flag and return.
         */
        if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {
                set_cpu_bug(c, X86_BUG_NULL_SEG);
                return;
        }

The hypervisor could provide more information so that the guest can
determine when it's safe to use the short sequence, but that's just
icing on the cake. The default, out-of-the-box configuration must be
safe.
