Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1030594E
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461075; cv=pass; b=mvJ0d4ggqUf0mq65cQ2TlLU/CrB1msd9PRD6b6Ktu+Tjuwq39mv1A0fiGfpdDSXWGCEjFTv/Kh9HmbYYX2UapGTqvfxebFPSYqq3KkGao43xRuUoAKBtJdfSCG00pN/814lQrND6etwWfo0ifXn3NP9DPk+b+j/aaK0XRUS5Cuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461075; c=relaxed/simple;
	bh=LfOHx404KK+zENd5k0iKvf2df8c1QUv6Mhd4nnrA2k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBwaJLkNYHJV5YEuxevIJXaON4NaAibN8ReSTa8QYqP4PbtGrI+QyZM86x2ztryzd1n5RwI+8VJDXzIpCZDvTXM3wM+BbWtFiQ3WX2LGOXcIUF2JCq5CjCx1gCHJ1kqcNRk+SHDueAQz8ED342ej2mthZLQ2puxR5UysrJ70I7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBgoRaE5; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBgoRaE5"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so1270a12.0
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 10:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774461072; cv=none;
        d=google.com; s=arc-20240605;
        b=hkoNPG5fbEQ00Opwaw6yI+ECqpUXN5UplMyK7AVOQO+cPXbgRWZcfPsgtXU/LYrfw8
         JyFbE77o7R0AEYU4DpZZPxZ1o1NU6ix6LpuwYwBoQ2kNgCqBY+q9ZppTXmfC/p9DezaE
         WSU24Nz+y9g9kDIqZY+vff4F2xAN2UIiWL0FcDf41r66svHXgWku3K1vd0NMkq/ZVNOs
         Km1ssumxiLuF68HifB0dstkJicqVGXB5mqx8sfghw7yX7oDitrKRa9yq4+1BZA5HsQJD
         RDYplpd8y5Un1yuDQpONXrew0HUuOisv7T1/cwm8EmD4NMSja7cIW792EYfcJ7RNpzLb
         YLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        fh=i4bLNrd8SwngBBhynD1bio0x/zbS8KZsAuhp4MI5nng=;
        b=XsS72oVD64lktX87sPKxTM0SyWl9YiltuTCZEUBvkrjMn6d+R0NOxLVmEM4ia4Biyz
         LVeM4ghmD8u/koOhz28dLSWyViY4c4FYbO//IKa4frEowz6EbVQ0iY33jDPebZEXDS7p
         N8SBCKZ/STN8EiGeDtH4ViEIpG7j3SQoSl7Y8T063+qchFwlTcbulWe8JvXZfzFCWDBf
         vbiVUjMEsDmfAGSV4w7e8VZbxOa+EICYOrbSa3XED79tJdcIu0VQ/YNw9yyhsL37YJAK
         GOb5l4+seHcbT1jr+8qQpi9YgsSL99693llbmZUh7BDTgLXmGiYE3s42KK+9Qwlx571L
         xQ3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774461072; x=1775065872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        b=wBgoRaE5KwE6i3/vMK7iN/ni9u9+TYMzEaP7tkYWWy0gg0cUFnCwffK7+Oq8zpLsEC
         IbACPzPlPOvbx0KK6Ip8IyIV+2WFJP382adRBpUvY3JecWL2BWxv6nt0A/XndS0V7mSL
         hB4c9t90mIljkfhF9TG/G+KHfuvxbyxq9ln6kopwRefmgjKx1Jll/gM00RVPu/yDMhiI
         ZbRHJLV9+4ksbvvrjomqh28Nipi5s50YLBFMr1TwHGlscvhlqvJL25FcwaqsQr8Q7ymY
         Xj3E2aVoabx+zpeILZSUFuFaZ1ofbvD01exhxo4Wb86TM9U2dxWwmkYVnXlm2+arIW7v
         yeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461072; x=1775065872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        b=WLT15F/aCamhRYUN6rboLbvK3KGyv8TDdztLdVEmhAEEzMwsmKo3avilLrRsOMG9Ri
         DAcXz7LramoQyHbB090jv1UXb5goeN2+5vt9L3qQ0kRB4gadF323Rtk2E+Qiw8bsWix0
         zOHwz1U7By/bVGSR6qa1gDSSeOsw+7Tgv2DzWZGwqWyAYPicw63FiJ+BH26QCYHFCP5y
         hoiaOOOhpH8AIe1LiqztcEZIT8IdxEV6xmqnoXda3LWkP2YER9PaeUMROTsmaIVTqXPx
         K0njJfqfkGIEQHBw5aMTygqD9o7YnAbW0a3WcdawY2GBJF+C14z7LFzWGtb3TyL0FB2Y
         MQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAGxNTdXTaAsY15uB3TYJhnUn0swp40tpqQ61S7YC7UqLfT4SdcpausCJW8QTjnLshDAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3wMKhvU+FR0Oh5sOvXWy2KrQO7Afgv3aoLe3THWu/Xar40ET
	6XF8ZGRfQnfrWEKlw+GlNCafKVaB6A2RzR3dw37WGUL+PFdorytAkQJC/hJ+thsCMUKwYJ0AMNt
	BD+meK9LGUnyMGPML6MGHBAGQBeBTO8+mq/q3pTlN
X-Gm-Gg: ATEYQzwikTAv0F9dYeK4R8JVIOXcHT9LexIEdkVVOYvqhOqLQPMq37a/8lwJTUwHk/F
	vMcv5YrRD2bdDsYOommfDsx2ugl12bCKBHKAapbaFTIYqjQUg4fG9Dc39Df947BLEsW+vYLUWl0
	aMRFlGED0VshtrvY1yt5oOJKVAYhmJ0iHLPrSkOnqPdkql3ZMgJTYjUKdmBRXza5QgKUKaRobG7
	3gnda96yqdaa7XzAQNKv8G8mJAxQO0BwHNan8ovBbJf/mavJ9vdLT6/+GAKXm5/UfrnoVNKFT4R
	pZ9BFTw=
X-Received: by 2002:a05:6402:1451:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-66ad9575059mr2781a12.7.1774461072029; Wed, 25 Mar 2026 10:51:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com> <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
In-Reply-To: <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 25 Mar 2026 10:50:58 -0700
X-Gm-Features: AQROBzDwHlJH5nkrozA8k_jCaaxMY2azgH1uzVE_N9olWzdVjI8yDoxoWPHYtxY
Message-ID: <CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:19=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrit=
es
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> that mitigates BHI in kernel.
>
> BHI variant of VMSCAPE requires isolating branch history between guests a=
nd
> userspace. Note that there is no equivalent hardware control for userspac=
e.
> To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> should execute sufficient number of branches to clear a larger BHB.
>
> Dynamically set the loop count of clear_bhb_loop() such that it is
> effective on newer CPUs too. Use the hardware control enumeration
> X86_FEATURE_BHI_CTRL to select the appropriate loop count.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
>  arch/x86/net/bpf_jit_comp.c |  7 -------
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3a180a36ca0e..8128e00ca73f 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
>  SYM_FUNC_START(clear_bhb_loop)
>         ANNOTATE_NOENDBR
>         push    %rbp
> +       /* BPF caller may require %rax to be preserved */
> +       push    %rax

Shouldn't the "push %rax" come after "mov %rsp, %rbp"?

>         mov     %rsp, %rbp
> -       movl    $5, %ecx
