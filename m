Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793384646;
	b=XKasTlA6HmlxLjhLYu3T2aEqFHSNR+xFfVuFIivF+WmLb30Ct5n8AK7Ji8pDpPMwSfR3
	 6/LAx3oqxxxYN/0n6GBO+KoT5gGzMTuNO96Z04I616QSHXATg/DcRMQJVSyTSQ/g4gFAs
	 tWWUU6ERib1HpvZFQHb07gW/OGbOBrk+MJYjdrmSyfrCrRTZjfya5IHGM5M5a9MBkYs7l
	 oqkSBa46PLTAVII65r9ZT4CbiXxQattWtOkQzTmVXkqimJahmlGj2ZZJ7GymOy64f21RI
	 3GkTJVD52Ser6SVsOCV4AVrT9KQpKAZq8OyGOQKVXRdkKnNs3yofyJSPpqHwy1jeC9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Fw1kmg+I1ASrdCP1OUgNo/WWfGRAnAaqRKHEspPk4Vc=;
	b=eYiZ+/Ni46j9nr/XTfGYKxm/Z07Vj9nrbsuwzMXCfahYTfHNGJFlzamNzCh30zydAxVK
	 k73TiycYGOH33QKRPquExL02weWZg9DVyL3/D/U9MT5/wHhdasaIqu7Oyn7Vsbb74Dz3j
	 ij8gniYB3sN1/qn4PCr1AEXah0rx6i6eqk3EFk2yOXO4a0snGqU8fOwu69N/37dO2x1A+
	 ZOvPQTd8JpcYLoChC3unuAGQKJFgH8OwYY2unVrj3QdiFYOv8tUbClLcE2k6CTSarvwbG
	 mz4XC16ep7dgFKdyjc/oXqwdBhIo6Ky3E0gAcDbEMfc6vzou2+G6DVKdm37gA5isrrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T4ruIAOd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905B606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9905B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T4ruIAOd
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5383c97c8cfso25081cf.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793384644; cv=none;
        d=google.com; s=arc-20260327;
        b=Mmp37cAhxG097nn3P3X9kxDJ75o585BUr4uAIpA57zGqGTs7AV2SovGmN9Ig7s4PBa
         6aE2ImG2mOUch9xVWoPREgpn7hJcV86IQtQc0QFlOtEn6wg/ZoK/8HCHJYiWlVC7eAb5
         3nf37FAxKlo8JLZzLCxc6N+3WSJKXkfR7yqC5lQ+Et/2eLcyJtTfHPjSnmc6EvBxYW/o
         ZRteHKPj1PI+aZJnhANxGPNUhURdNvVdhdwRE9QoahSo42cCXsh60jCAvG4XcpCXoDx1
         Vpxu4Orl1EObposXvfI/XyxLrFkViVeGIr0uLhqq9FXVKx16PryTzHbzF02g3Kj4iCsg
         LcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fw1kmg+I1ASrdCP1OUgNo/WWfGRAnAaqRKHEspPk4Vc=;
        fh=TnVFjPn5JbrQbv1TPufSU/l1kfvoJHV1QbI6Ccjia8M=;
        b=JQuj6l555hOL/9o/rDPLgIiNMcMXbCFFh03PlykRDhZ+o5aJfBnx1D3vSCFGYWgxhV
         Rx28qlZh1O4qEOgZEurvQqoUAzTuaEsBfWqLGfI401gDgFdHvHXOz1OYEFTydnZabJ+s
         4gihtWZrOz1sX5ujDxjG2uON3nN2I+4a4cxlQnHoAsP0Qg/5f8v0vmbsXNI9OF6Fn+ci
         RG8ZKRxNjr4Fw64og8bwWzE3yoLAcUzI1JFeH8skbf+3UnTZMejg4JDgMMy7wNd3cdaE
         x2DGqqSLuYbf8oa9oX7qpOmx52RfZtT/Tb5bLL6sPvFXLUnTHKQwWuKxHesCCXPKoOnf
         6WGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793384644; x=1793989444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fw1kmg+I1ASrdCP1OUgNo/WWfGRAnAaqRKHEspPk4Vc=;
        b=T4ruIAOdTtx8ZxacqgjXIAGV0SmNNSJS/QwhXKBiHoOxBRoufgxlPFqxFtfAdR5jIK
         ZY18/LZOP3HAqOCVCF8ukpR3+4Ho7nljIaFW7cb6jqW2BesfIOfq2iCD6Acn7FS2F3Vh
         Z3PcXBbgdSzvAoecIdCPDeiDInqQdAQugWDRUXYlNI2+Y8+xNBXTpjFp0PCNHSBkMjtd
         EQUTVGE+GQGh4rphuXx/jPl15iRNpvjEW1lHLxbsmqSUQEHQrKYQsqOoUi33bRrJsk/J
         K3QF8A/0P7XhKoJkkDZxlG3cbWJ4hMCZsZuiwZ1KmMljE7OpGR0Pa2/3FFcLxQK/2aQX
         4/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384644; x=1793989444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fw1kmg+I1ASrdCP1OUgNo/WWfGRAnAaqRKHEspPk4Vc=;
        b=tUuRxqKlE7SGrRUSFdHqtR56/WNtA5bulSHcJa0ZpbtsgLsjoT46QfvwsvDhZSTbNM
         r7sqR/IYOlN5c6zMKYmwpAaiTIglzzRVWPn/J51PsX1t9BaGvnevgyZP5glYhY4XybN4
         CKAJ3JzZogN59lcic0sZ6w6cS6JJz1AaeLzF93SaxqCNgLtjWgv8JllUJAUeLjNfCmrA
         YUQ0nFRNpt3efWvZJkxHpPyRCpOm8EU9MnOshsNIG3eUFpeHPUHuPP0kcspcg50ObAM6
         0Bu6j+n7mtjgwA72t3ifXKRtb9oUazVC85JAmdrNpvJvu/ooZf23nRh2Oy0cW5NpFyX4
         7eaA==
X-Forwarded-Encrypted: i=1; AKwUvBwR62VLBv772KKHI7ACdY09gP5ksaPAhZD09Wn9/CVhRAP1C/RVfd8jE462D/zDqzZ0+/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFE7wHPs0UmX0LVF5eUsvo8TRacArVLHEGNq+pehYctfL7vPWy
	mph0QKltPl4r1HQdwz3Neqx5XOSAYcnl3AhYiyJ2pW+6bBwhzmsOrtrqfyGaoX8eZg1whVSW8fn
	zf7TAR8cc2i+m3xVDQsAgQnRY8ku1lTQTDmc7X+dW
X-Gm-Gg: AYBFou1r4j1N3w94R52TfYi4JuyJl+Iy3X5QmJAn1N7uXw4jZwKRNmo+jItpDtXifMd
	QHnMXrXrueiyaYfwQZ9RucIHKchvgSIJc+egbx1HqsbQHSvKO7j3EKJy5tsd6NjLUEzpPXLWaEo
	zlF/jMeaSgDSK9mrTpNWCtzoON1EX/I8LwLF/oxevHdqbIoLatCJIPwSRlfjM3uQiV32nqewcRn
	d01J/VbtWgHYufSirs+0oXD+pFqOXETPb7VNvtMCQ/L4Iin9I+fhqtndRe4jeKNcqccVfa5mWaW
	/ust5o0b00GlB5EutbJf+TrwiQsbMv06BYdoJgHoAg5Tzm9PUifKvGZB9hXj6RQ9ILpupcH56aC
	5LlJDdkbmDycVShZj1HgxJtSuVSh2h1P1Ue1i
X-Received: by 2002:a05:622a:4d46:b0:535:84ef:2e26 with SMTP id
 d75a77b69052e-5414de1ec9amr50031541cf.7.1793384643499; Fri, 30 Oct 2026
 11:24:03 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <b3dcb403-ec19-4d23-9bab-336e2eb344bd@intel.com> <CALMp9eTHRzXXm1gpKR3u1nzJU3i9M1a_wUjp9+bD8_r4eoPQ_Q@mail.gmail.com>
 <dc0e6998-6b8c-4b0c-a04e-b6af0a1cf653@intel.com>
In-Reply-To: <dc0e6998-6b8c-4b0c-a04e-b6af0a1cf653@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 30 Oct 2026 11:23:47 -0700
X-Gm-Features: AclHuK9E07m7dz2wKjkFpXS9KkhXE21jPyyRBCg8pZLGFJS_nCKIByMBt2PJplg
Message-ID: <CALMp9eTRTLGziPtrSG9tQWLqoUuz9zmrRwUis5gb-wSeJeA7-w@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:20=E2=80=AFAM Chen, Zide <zide.chen@intel.com> w=
rote:
>
>
>
> On 10/30/2026 6:55 AM, Jim Mattson wrote:
> > On Thu, Oct 29, 2026 at 10:45=E2=80=AFAM Chen, Zide <zide.chen@intel.co=
m> wrote:
> >> On 10/28/2026 4:24 PM, Jim Mattson wrote:
> > [ ... ]
> >>> As I pointed out in patch 04/16, we can't pass through the PMU global
> >>> controls unless their reserved bits match hardware.
> >>
> >> Totally agree. Then the handling of bit 55 breaks this rule as well.
> >>
> >> if (vmx_pt_mode_is_host_guest())
> >>         pmu->global_status_rsvd &=3D ~GLOBAL_STATUS_TRACE_TOPAPMI;
> >>
> >> Always intercepting GLOBAL_OVF_CTRL and GLOBAL_STATUS_SET can solve th=
is
> >> problem, but it may impair guest performance, especially for nested.
> >>
> >> Instead, I'd propal to have separate reserved masks:
> >> - pmu->global_status_rsvd: unchanged, strictly tracking virtualized
> >> guest state and preserving live migration validation.
> >> - pmu->global_status_{clr,set}_rsvd: unmasking all architecturally val=
id
> >> hardware bits for the corresponding MSRs on v4+.
> >>
> >> Any bits allowed by hardware but unvirtualized by KVM are
> >> scrubbed/filtered in intel_mediated_pmu_{put,load}().
> >
> > That is a terrible proposal. MSR bits that vanish at unpredictable
> > times?!? No. If an MSR contains bits that aren't virtualized, that MSR
> > can't be passed through. Full stop.
>
> OK, I agree. I will intercept GLOBAL_STATUS_SET (0x391) and remove the
> nested_vmx_merge_msr_bitmaps() for it.
>
> However, I propose we keep GLOBAL_OVF_CTRL (0x390) passed through, even
> though its reserved bits don't match hardware. Since it is
> write-1-to-clear, it cannot manufacture unvirtualized state or leak host
> data.
>
> The only divergence is the lack of a #GP if the guest writes an
> unvirtualized but hardware-valid bit. If we want to eliminate this
> behavior by intercepting it, it will force an additional VM-exit on
> every single guest PMI.
>
> What do you think?

That seems reasonable to me, as long as the architectural misbehavior
is documented in Documentation/virt/kvm/x86/errata.rst.
