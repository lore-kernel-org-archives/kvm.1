Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC830216D
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940362; cv=pass; b=shhMNPbLqv7rdbmiN8FgbS3LEmNsa9KrS/OWv0G8PbBBw0eWPBoV/iT0a6Q1pL8PZpinqbGvwF5KMaKGsn/Xup7rQPlQhwyzz88azEUrhphbG/IPoFgPzy+TXZjwnPSLPudg2QzIcCpoNaeiORwAuioXroM1KmVAx/hET1zTj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940362; c=relaxed/simple;
	bh=lpIs2XFFMgCO2eDKG9XpvrzJFsvhZRkiOhUb37vJUuk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puHfzcopYTG4NfFiyAOCTcF8quhKn24B78DELoL7CTominIdJkDTTSUvPHH4K0FbWMY4xHrbwTQuSUo+61RkbhMkUtVlwVmmqaKZABRGpa2C+H2zkXGjGgwWRtUbGgOSbNzqO4qrXKPsqBR1BLNbCLnFlo4Jmy0ZVoCekFVLNPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4Z1qDgx; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4Z1qDgx"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2140503a91.2
        for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 21:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786940360; cv=none;
        d=google.com; s=arc-20260327;
        b=iPfbmYyfPTuaZ51PNe65lubWvX2/M4QKeu//kg7FdO5jc1bxKRHL0QMRMLEA0cjz0g
         5owOFa9ThqLAF6NcJ6P8bVdq8SmVr+pTP+TggBwzO0PEkHU/0kKCHZ8JXElCiVZtYAhI
         cgqeTnmD4pW3IZUYusp+a3rBgHps8I6Vwbe6xR2NL/q1Mq9bRKSlvhS4u8N2miTpVNxH
         f3Kvjr8dIWPR/OxYuzncxaZQYOTbOforPwsT9C6W7xBIeJkTbQTSanP+bODq0rhdc4Hs
         I9+ElFFr1Qpwv7UNgBBCHMlSF0J6vg75AMYV+1WHDG5Nz+dhLP5hU0YtxFRu9WxHP9XH
         QP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xivEul2vQ6DVrmdcX4kLhJE8WzqBo4aY4NPSm+NocTk=;
        fh=JZMODi/udyKofpHC22Oik7ypB7wG2Zj/TXpwEXq+Ycc=;
        b=qOlJ0/Vs0RTOzNQxuXYgY/ZL541IIRMCFZFBYcyLB7n2HHdoNxGqaEb+fG1oNE7/8x
         jObUYHbpgnws0aeN9ILrkecojgNnAOljOlj2y0WEkxvxdvmJO55WXnwe1HFr7riVPINc
         rINQVIhaEhRKnYBvRaPRII5zc/gLO2cfNVNEhLktCra4hSCYgpSk1NHdJnq/be2qQC5n
         SH3KIDNEtn1Pk7n07CKd8JLLKv0t1xa5iermdPuSOi2l+DFj1FE/IqbeVf5si3fH8frr
         LBtI7g3F5iA3KIwsSmFha+nrReXcZbec30miurAs2jzcTJ/RW013uHwjD/o7D/zRAqFl
         TneQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786940360; x=1787545160; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xivEul2vQ6DVrmdcX4kLhJE8WzqBo4aY4NPSm+NocTk=;
        b=d4Z1qDgxn//0BBIeicBMU83aBpv6v4tsbWYbUbIbSVWScYdFNjNy6C4K6w/Ow0EURs
         I6R75I8GF57mZEt3CfTmnNDvZmbzHlUitckQjbTItPENaCMf+5+bi9nLe+OjcODUWQnh
         BA6k1m5oq//xD4QG2+MRyxsfvIKbOk/9z1eUkIgimDGTS/5w6UbtzFfKWUaxtgBsZgQO
         J3pX1wsUVan4fCuTH/sYLY1fKB3gZNXm5yED8i5TsQUpOpdj0H6Ql7AxkgmFUEol8yLm
         8MYJdbE9mTnbIiNDL9GPzIqx11IbJy4+gdtTzOraOEU4c7MzXGoiCo1rBp2uEu5TTkvu
         QJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786940360; x=1787545160;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xivEul2vQ6DVrmdcX4kLhJE8WzqBo4aY4NPSm+NocTk=;
        b=AFn19Ew5Kor/XFTN60VNCGAT0I2FHFczMNQ9LgOPrk6pNisSFbU1NGstr2Xrxtvz/z
         f5QqS+0ysq1nJKdKBJy+Ezk2nwUnE5YSivRmSH5moNADYpLq7UJgLf+sSiYFj41Uq2DH
         eTkpxkeCcmT/Z8wYkciZlLvtOJYzQVOVJw5M+1o+EGRhmG9bGuWyUFwNHoVtQKV6TtNU
         giv4FzQT6h8quOm8qJDWjKNMUzEeFRvyZevn0T68EgJ231ahZaKEGkxW99AiiV0Jnzu4
         F3jwg4P++bVSeQMioq74FUCLAFqQhvpEuGrPIwNAah9NmrknHHOjHt6X36lPuRmJNRLj
         vmyw==
X-Gm-Message-State: AOJu0YxeBrW4SK+N6gORQb2pOJJ64/0pSQj8y+QqyqvIizIPPDqwVDu9
	/6CQu5tuokHb8gE0bmxKNMyOlLngvwAfLe3k4zy69UEyC5Dh4DP7xnzaA86IXZKL8sr4xnrphO1
	IhTEBR3ece8PfJhZmFr5OwoMtPmCjgF4i6lXNHhxq
X-Gm-Gg: AR+sD11ZKVv38dslVqLBVptVPsvcAAsC/Ut/cydvIwILnoktGpOtgQtXZrWI1ZV61dA
	3fpe81UsUSpqjYGnL1tIIkLtojPcqru4Qbdqa2dXqoUSx0WCrSGKZ4enW+z/kMmsfJLTa3gwCOl
	9aONivAvOONqfUmBxcmw6/LlpIa1Cq0fzhTRZfHleJhOBUtFF1GM4Zs1SpNsziSqQNnm1Tki6QD
	lsHvaBjyQVd/J6GO3bWnHmGPTK45XgDPp1Ug7QGeibsUplGrSmJ1S6+buXv4SwK7mZaHch3b1l5
	vL+eJTBg/KKyIyabl8QlWZu0uPCwne8tMEExh2RmgvOApRv9keTjV9R8pQWGfyzMeJoKTSpWJvo
	p784Jzm0a3uJ5
X-Received: by 2002:a17:90b:4c92:b0:37f:c28a:de61 with SMTP id
 98e67ed59e1d1-3933b958b03mr19010729a91.17.1786940359155; Sun, 16 Aug 2026
 21:19:19 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 21:19:17 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 21:19:17 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com> <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 21:19:17 -0700
X-Gm-Features: AcwNN1VIHmwnnDA2bzacKAIVX0yEdPw0lSMkAp36cPs6xox3IG56dYLMbQiMxOc
Message-ID: <CAEvNRgELDhXvPFKaoz+w-yywoJn0WMWvA-Y2jfdnwJVSbCSWyw@mail.gmail.com>
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "afranji@google.com" <afranji@google.com>, 
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, 
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>, 
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com" <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"Wang, Roger" <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Thu, 2026-08-13 at 15:47 -0700, Rick Edgecombe wrote:
>> On Wed, 2026-07-22 at 23:13 +0000, Lisa Wang wrote:
>> > v14 revision for TDX KVM selftests based on kvm/next and guest_memfd:
>> > In-place conversion support[1]. This series needs some changes from
>> > in-place conversion v9. For ease of testing, an extra hack commit has
>> > been added. The complete code is available at:
>> > https://github.com/googleprodkernel/linux-cc/commits/tdx-selftests-v14
>>
>> Are you able to get sashiko review on this? Or did you internally somehow? It
>> seems the public sashiko cannot figure out this stack.
>
> Actually why is this on top of in-place conversion? I thought the idea was to
> break the series apart to get something basic upstream:
> https://lore.kernel.org/all/aJ-6JpHD6xhAvZPy@google.com/
>
> Adding in-place conversion tests seems to be going in the opposite direction.
>

We wanted to have this series based on in-place conversion since
non-in-place conversion is on a deprecation path. Also, it makes the set
up easier :)

At this point I don't think this series is going to make it for 7.3, so
at best it makes it for 7.4 (together with in-place conversion), which I
think works out?

Sean, let us know what you think about scheduling. We can rebase without
in-place conversion if necessary.

>
> Also, the branch does not build for me:
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:26:
> undefined reference to `TD_BOOT_PARAMETERS_PER_VCPU'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:30:
> undefined reference to `TD_PER_VCPU_PARAMETERS_ESP_GVA'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:33:
> undefined reference to `TD_BOOT_PARAMETERS_GDT'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:37:
> undefined reference to `TD_BOOT_PARAMETERS_IDT'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:44:
> undefined reference to `TD_BOOT_PARAMETERS_CR4'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:46:
> undefined reference to `TD_BOOT_PARAMETERS_CR3'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:48:
> undefined reference to `TD_BOOT_PARAMETERS_CR0'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:54:
> undefined reference to `TD_PER_VCPU_PARAMETERS_GUEST_CODE'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile.kvm:351:
> .../linux/tools/testing/selftests/kvm/demand_paging_test] Error 1
> make: *** Waiting for unfinished jobs....
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.o: in
> function `td_boot':
> .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:24: undefined
> reference to `SIZEOF_TD_PER_VCPU_PARAMETERS'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:26:
> undefined reference to `TD_BOOT_PARAMETERS_PER_VCPU'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:30:
> undefined reference to `TD_PER_VCPU_PARAMETERS_ESP_GVA'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:33:
> undefined reference to `TD_BOOT_PARAMETERS_GDT'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:37:
> undefined reference to `TD_BOOT_PARAMETERS_IDT'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:44:
> undefined reference to `TD_BOOT_PARAMETERS_CR4'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:46:
> undefined reference to `TD_BOOT_PARAMETERS_CR3'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:48:
> undefined reference to `TD_BOOT_PARAMETERS_CR0'
> /usr/bin/ld: .../linux/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:54:
> undefined reference to `TD_PER_VCPU_PARAMETERS_GUEST_CODE'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile.kvm:351:
> .../linux/tools/testing/selftests/kvm/dirty_log_test] Error 1
>
> If I apply these patches on 8cf3969a0b7d4 from the branch, it builds though. It
> looks like a few changes are missing from the branch:
>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c
> b/tools/testing/selftests/kvm/guest_memfd_test.c
> index d6528c6f5e031..b099b09cbae3d 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -14,7 +14,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/falloc.h>
>  #include <linux/sizes.h>
> -#include <sys/mman.h>
> +#include <linux/mman.h>

I recall a similar fix [1] you posted, I think both Lisa and I are
relying on some LSP auto-including, we'll adopt <linux/mman.h>. Let me
know you know a good way to configure the auto-includes.

[1] https://lore.kernel.org/all/20260427204313.50741-1-rick.p.edgecombe@intel.com/

What compiler/version are you using? We'd like to reproduce.

>  #include <sys/types.h>
>  #include <sys/stat.h>
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> index b81cd16198ecf..7f76a3585b99a 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> @@ -5,7 +5,7 @@
>
>  #include "tdx/td_boot.h"
>
> -static void __used common(void)
> +static void __attribute__((used)) common(void)

Not sure about this, I'll let Lisa look at this in more detail. I wonder
if declaring __used is necessary at all.

>  {
>         OFFSET(TD_BOOT_PARAMETERS_CR0, td_boot_parameters, cr0);
>         OFFSET(TD_BOOT_PARAMETERS_CR3, td_boot_parameters, cr3);
