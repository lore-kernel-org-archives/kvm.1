Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F235DA46
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467714; cv=none; b=MOhEH+UIvulqkcEod5uiMxv4RoU5Lkhkxl+dhos/3CVEdCjWmzJQl6RvWXGt5UcrIHzjUnvP8vMAAWDtMgZMi5a/7jvry4D+RbF045r3I8VZl4LQMpXvcfTnHHJ+CrY7RZbzJqXSGmg4g4M4Cooo6mnUkmzRdxnNnPGfPuHK+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467714; c=relaxed/simple;
	bh=d+nfjMfEVHf7jtz1MIQh+squ9QrgehK0qZ/mTLc/EZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tueWMPpC660+DuH3/K3tPBgXs/eSJJdT+rjXfHTy36V1usiBDFlVLLH0buqQw09KrawgqxMOMVqfpskBSVxFp9N59kQ/wSziYbicnfBlDDT/XwQeq7BegvBu4TxzzDy8a7FWptMaNvr/srAzT5IapSNzuEANgj5qWgDPeUBXwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Zm4OEg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Zm4OEg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso1834215e9.2
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774467711; x=1775072511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5agou4BHmM67c6SSsDwlj7qtFxZ2/CyU4qlcqH2Z8DI=;
        b=D8Zm4OEgE7zuhMoO+TLA6zFkoCvrIu6Zulcl82z1eiQnUVxOyFpLzEDJ237N96a63L
         q+ghLzhGjUVdtJnfPtk7wsAP1ykwBAmNJlRKmggQNUTHhMPdcqaYhrP7YYTLu7QwPU7E
         GaN3y5XNr27D8BOGXzhOvOU8idIz+YpoSyZfo7jO4SjvekAgsJzLKIjJWXMm0/q4xdtC
         R6M7fMSu/bc3U1VVmsE0QnTRmki7frlt9B+QlFeLeRPkftJTygbzwIyQ0sCjLn/MWkI9
         LIcPpOgUvglVrXHmspUF2S0XPWXnf0yu54sjnr0l2jWGbRVq3qgGH7hrpA16cU+ymnpf
         r9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467711; x=1775072511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5agou4BHmM67c6SSsDwlj7qtFxZ2/CyU4qlcqH2Z8DI=;
        b=VyAivBRBQVm01HkIVNLc837/MIitSZGcmFThxr89g/RwkO04GzhLobXRMxBpo3H+TF
         bQ1PWxz5snPJBGBKsP4hV21tBrgJ6iHWjN3wfgmrte3w6s8K85CUTPQOeHCe8DH1FnwV
         0rFjrwgfY8FQFGLwA7B6Kzzcs/FDOIfpbo7BQKCAK/X1Ob9o+GvAdbockQheckOYVtqw
         DKKv3ekSWjG/SC1yHw/Ip9GJ41BV8ct91ZCJFT5PuwgnxqBh2TpwHGxa7HvTDvEOrxaE
         dOQMPzOmJP6TYBijzzj+A1X7vGGPa1EgMee1J4U9hqm+FVmklG/oDwWFTtI/zP7lKbrO
         +HZg==
X-Forwarded-Encrypted: i=1; AJvYcCW5EVwAlxzUTXvLADl6taBPitj+gd0Okojlb5FxiXAT7pEowW54j+6XgaawblVmXVRoLS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMa8r1wk8Cr4HqKf11GP8C1ne2siw7o5GyRYENGrqYIUWbl+o
	Psl6FCKVMRJDDlojMweUBbV9AuAEZkn9Sa1MUYWrugbqazPVNRcJHmdn
X-Gm-Gg: ATEYQzwa6dru9idluwHjGKBLF8KPgcC8IJbvQRnKBzE7n0gda6/sEjnS8j1lPi4RtVo
	o1pSg8o4ahHE8Nza64OlXu9arjC0lCyH/OojEyWB5I5sMITNDynLRACf4LTIsYI0QfmVUwFYSm1
	a9LtCLltPArYlrbbSJ2DkepPyZZBkhHI0ICqdTA/vldIfs+7YztOALZJjLbjp8TR7+zB+MTY6Wn
	pMu5Inw19JT0w4yb797SNrjwFRPizTthPRgk8kfhVMm3q3vHwv9bDDWTKsJsBc9EyXxMMQ1B41Y
	zgVn9zf545suxCDN+1QYVzAEFRnqFLAcVmnMmzs+c2paQCcEI1xr9nfpXWllYqUGKloQZtwZJMj
	NtOOZXO+3F7mk23PQirIGHVRXJGTZpyxKsAfk8vEk3hT8ThFnGqgu+rx/bpatLBLV2wYppiyv3b
	cKwIiRqezZYy8qvk9aWAWprx2PfhWsFuXB5CMgh/jTkgcJXZF2EV5iOFc7V8vRGejk
X-Received: by 2002:a05:600c:1c22:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4871604c8e1mr76733195e9.21.1774467710858;
        Wed, 25 Mar 2026 12:41:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbb58a0sm688705e9.23.2026.03.25.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:41:50 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:41:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jim Mattson <jmattson@google.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, Jon
 Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andy
 Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit
 Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260325194146.29c91953@pumpkin>
In-Reply-To: <CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Mar 2026 10:50:58 -0700
Jim Mattson <jmattson@google.com> wrote:

> On Tue, Mar 24, 2026 at 11:19=E2=80=AFAM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > As a mitigation for BHI, clear_bhb_loop() executes branches that overwr=
ites
> > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > sequence is not sufficient because it doesn't clear enough entries. This
> > was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> > that mitigates BHI in kernel.
> >
> > BHI variant of VMSCAPE requires isolating branch history between guests=
 and
> > userspace. Note that there is no equivalent hardware control for usersp=
ace.
> > To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> > should execute sufficient number of branches to clear a larger BHB.
> >
> > Dynamically set the loop count of clear_bhb_loop() such that it is
> > effective on newer CPUs too. Use the hardware control enumeration
> > X86_FEATURE_BHI_CTRL to select the appropriate loop count.
> >
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
> >  arch/x86/net/bpf_jit_comp.c |  7 -------
> >  2 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 3a180a36ca0e..8128e00ca73f 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
> >  SYM_FUNC_START(clear_bhb_loop)
> >         ANNOTATE_NOENDBR
> >         push    %rbp
> > +       /* BPF caller may require %rax to be preserved */

Since you need a new version change that to 'all registers preserved'.

> > +       push    %rax =20
>=20
> Shouldn't the "push %rax" come after "mov %rsp, %rbp"?

Or delete the stack frame :-)
It is only there for the stack trace-back code.

	David


>=20
> >         mov     %rsp, %rbp
> > -       movl    $5, %ecx =20

