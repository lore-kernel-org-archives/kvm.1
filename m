Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837C3BA25E
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941809; cv=none; b=CWso1Pupcnj84e8dbX5IXWrK2aMM/epyBY+ovgZVDA74JvWR2ZvRURIXQ+fqlTCO4AUgNEtCmk7eipwSctGvHdmdl9W2Fh2vAS2Me2ddAobjyXS4G2PS/LD7Pe4JFKBC3O69EZTJolLzVqCi3fZbS/eIo95jeTaidwhCb3wy2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941809; c=relaxed/simple;
	bh=vKhe6i3FkAFwErgQ+z+E/6b1UcU6MpKf/+QS8ZIRiqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2GlvcT/Hjz9bGqVfEa3cv6pZTt0IEkudy0vgrnfrlGHkzpzLd3AwI+kANhed7vmAYaSlnsDIH54lVguGK++bMisPzUOimj1lKTwWu653wdSAMfA6pJ8CsXmhsxrprI02H64GP9ozlF7UZDX62qy4PputSQpPWgfFf+AI5m68VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lD7iZ/KI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD7iZ/KI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b440b97aso12755ad.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787941808; x=1788546608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ILzvij1drwo7+iGNKuxy4V2qVsnhp5pYEXxx5p1BgD0=;
        b=lD7iZ/KIaT+P1b10Fzf3jHgWDWLGTDAZ5sHvy0TyB91lNps0NCV8QIsMHBRXmWx5jj
         s9iWmpRUFgl79dvb5ZnTniSjMyxabCP02atOIxIeXRaEy9z2VhXWazeQICO4kIhupiWa
         xnQhf3zSb2mPZQvwAw3LF7Xd70X7Le8TbPUh1LHIG0pB6lXbDX0AfjIyOJd3ueL5Yiwp
         Bbtq1tc7J/eEXy/8vUX5HzT8BNZwpncTzRYgq2IrwJHVYbwDDKDAs3vGjHUJ72dU4UOd
         QvYfw88MI2RSBE/3GRnEnJ851d/zeXnFMPLkjLcSehfcdyAaCz4L5LL+pvtHCTOOnNjE
         BVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787941808; x=1788546608;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILzvij1drwo7+iGNKuxy4V2qVsnhp5pYEXxx5p1BgD0=;
        b=kq5a8nQkiYnY/FSVzuymsoSk3yRUerbagihyGQH83Qivap0Tvpqae68JqVKpaHcmLa
         5BpDHRUaeQU4cPSXEkeNvsDQlX9ut1ptv+pjX34gtrsqkncQeQcyze+En+y2lW0Hr/Td
         hQwphRwVfXMDTTv0ALP7/wZMTlNiUKeugMMTJeH63y6Qfz1Jh0meIIAKCBxnR3PHB2lA
         GD3Nghyopb0JnZLZgXzr16oHkPkIvq9nE21ik1myqN3o40A17qL4UuJXIiynvV2bESc3
         oFLdS1+kBvrUG8nGBVzWz28snsze+mYpIL88ExZlkt8y70SpbMA1x22BzaC4KoMa8B2Y
         OEdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYOY8WvKCrUikyxdL+x7G7My1lhLOvR50dnfMtwZ7mfWqfBECguPFE9/m7XyXkEi33xHY=@vger.kernel.org
X-Gm-Message-State: AFuF++n60x7yC6JV2a7MPFvmA+I/NNB1PYTCC1VSQ6i6eA2yH//dmf/z
	/lg8fQ0XpMbteKNAuHeurgQFZ6KLy0h2+Ookk60gRdFf/XJrdFGwnT04UZXqBQcTiA==
X-Gm-Gg: AYBFou1/ajfEAc8nt/sbmdl0YHYh2tiJx8Vz/0P6xLhiWHZ+ZC71aoYoPfoCLNB8KAG
	G/IJW8kcdq7XNFDdFy5G2VvfzDcuCYml+PArPE0ija1wYaVptZIBWvL38o8QelpKUXE5Qin8/K6
	RBkFBWAUTiN/N5MPMeEBoQnDUBEXFKArJPv9XrVatf4squ1cqHs6RmQvWkSPHe5qSPb2Be3h645
	K8kGMklSb8mTV2T6bKKsh/LyIMxqq/Wb558LpqfHK3w7oGL1DZBb1A/g3Hi3bpMOriEdBMlacrJ
	mkoDoz7io72SU9IGkIqy7rZUxjEbrbCev35luHumupHW/j9Grmi8rHscfT07RVOUnV4NfH5/Sc1
	uldZGTfRWgqrNwgWMdxlwZk7CmVurlpa4Gen80s2P9qdotkRxtEz2A3Gz4YdMiGrmWCrb7dg9iZ
	Dl7rQC+NpzGzTL/2PVZ7G9ONWJtZRYOsLUdeDQ4hzlfWMZqiC07kHgSZjPFtcDPiOeyysVuivBN
	FmEZr8hf8SXlfcFDxUCtJ21
X-Received: by 2002:a17:903:988:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2d8dfb0b68dmr662305ad.1.1787941807055;
        Fri, 28 Aug 2026 11:30:07 -0700 (PDT)
Received: from google.com (139.58.247.35.bc.googleusercontent.com. [35.247.58.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d2309637sm1500859a91.0.2026.08.28.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 11:30:05 -0700 (PDT)
Date: Fri, 28 Aug 2026 18:30:01 +0000
From: Lisa Wang <wyihan@google.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Aktas, Erdem" <erdemaktas@google.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
	"oupton@kernel.org" <oupton@kernel.org>,
	"sagis@google.com" <sagis@google.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Wang, Roger" <runanwang@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"Qiang, Chenyi" <chenyi.qiang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
Message-ID: <apHTqWg1hDXpvhgE@google.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
 <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>

On Thu, Aug 13, 2026 at 11:05:17PM +0000, Edgecombe, Rick P wrote:
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> @@ -5,7 +5,7 @@
>  
>  #include "tdx/td_boot.h"
>  
> -static void __used common(void)
> +static void __attribute__((used)) common(void)
>  {
>         OFFSET(TD_BOOT_PARAMETERS_CR0, td_boot_parameters, cr0);
>         OFFSET(TD_BOOT_PARAMETERS_CR3, td_boot_parameters, cr3);
>
Thanks for testing this! The patch series posted here on the mailing
list is correct, but I made the mistake when pushing the code to the
branch.

I have just force-pushed the fix to the branch. It should compile
correctly now. Could you please pull the latest version and give it
another try?

Lisa
