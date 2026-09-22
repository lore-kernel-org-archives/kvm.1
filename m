Received: from mail-wr2-f17.google.com (mail-wr2-f17.google.com [74.125.225.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8241951354A
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071808; cv=none; b=P8Aqc4djxKTPri604UjtXImiewHwoBA/pTJJZ4fLKnxg34ZAXxFFuDjU78WykKcdAQrKNQEBOHW0vyJWfU7FmMYo73G8P/O8+ub5W+evjqEFpe0jQw3AU5efXuoCNwOws/DWkta2UUFxYCXpXiCtYLxOjy+reaWWYsMahdtgLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071808; c=relaxed/simple;
	bh=sggFhUneseUUxNVvYfEFQBkjkldLvBabYngF3pTDj9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiqefIOlxwakA9KwGk5C7+oEAahpL8r3GjKqDyHLLO8+nA/eD+gKTMyc8SiFkD1DMfymVApzR2t4FZIMAKAMj7y9qWSoaEu5Za3mVWP6qfOQcgLocLnWX80Y6UHdHYUSTT4oRmnJoYwIHutPPMmOlcVBXCMBLuLwLTTDuxWi3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MiORHtDJ; arc=none smtp.client-ip=74.125.225.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MiORHtDJ"
Received: by mail-wr2-f17.google.com with SMTP id ffacd0b85a97d-484366874b0so2329746f8f.2
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790071804; x=1790676604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=govxJP7/xHDPoXMa1qqKKxuu4w8EfasM3Ldya35nIg4=;
        b=MiORHtDJcyVHrLaAk0FsgsDRuRtB9VBuLVQdJ9R8wZzL2AW1eGRbFQO7DAZNEZXuC6
         SwtgG6irwKW8FSv/3lZ8fUO3ypK9dUjWY7VvebEXmaYVBey7hnh111u/jQZqIarWPW9J
         IJ7KiqBFNkgpQky3rZJzuwv5i7XgGOyDmzYcGPR+sElVOLjnh3Kmn5sJg8aFGCQ0t8Ns
         AlHT9owOoxFe7PkONwWxaEofi7fAWDOF5AFg9gBLFhkBT//lX5hAkKXnBdKpXe0wiRLv
         zBtnz0xvFjq2XMZANd4Zi15/ILegqqiHUdS8f6mXsPvl6emkZaezZFu4fQpQSTloe6uH
         TvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790071804; x=1790676604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=govxJP7/xHDPoXMa1qqKKxuu4w8EfasM3Ldya35nIg4=;
        b=sGSDqvlNLais9PGhPUMhr5PRc2oiFDSVdy9Szm0YBOgXqaI6S3wbGatjQNkJ0TvYhU
         p53aWWzv3C8ds4s0Kw6gRRbBxE2NIYCUOTzInytXFqfWarc1PzyqMf0E0kdnm2tE9dfL
         wLV1amkFiObjaKfpjmWYVWql1FWNURFNuIXfD7Uy3LYklDX704oJR9pGSnMvT1R7j6K5
         l2I4O5/YGx//jGYwCQCGZBSpCNV0qP2x3aDSWcHUO+A/j3qtD1vLvLD/VYoXvM8Ke/PG
         01XioNF/VEFm+HcNFaw7X8XYvNOsYccbY6t6n6Tf5kZFW5Lu2h7DK/kyn61vuteC3Sny
         33Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxOQ1X4rP8LXhrb+nuOXj+iyBUrM4QoA8gm2Wikc7sBTbAx2LEFYsVueGkGnPjc71pjyyg=@vger.kernel.org
X-Gm-Message-State: AFuF++k1kvXYL/uxDoCjgdefb1V+lwH8fC14j/8anxqnzp9DCMqm+dQD
	Ku5sUj+6sQGnPuRhneztZZZAv7QL7EFAVWZ1VV81fjuIw0q2bb4GjHxBZ/Urm/xEspc=
X-Gm-Gg: AYBFou3aTNerJwjKPC8OC54MDUtPlHB8FvoliyrmyP4ECNdTfKX56BYJDQUUKyUb7qS
	Eq9piiz9e+vzHYgivsGOPtcqXW3u17ul/x49ToRpUI61g7Y8G1bhImx/9cOsNkilOjcN7lr2fG4
	OiPwT+Ntvvd0sYTiC9CIOKFUZsU85/RVKggYP3NSnUOfPLELNXHC+Tlh1nmxheWFmL0dKWuY8b5
	HDDCxVpN/D3O8hXrpq+SP/wP0H3U0QtxS3iUGSG6yWSq8ek1FhN29LjmonDuTReTczB1fde5AfM
	QCp4MkC4/yIxGetPf70sWiQ4c42wws7ot0ZIiow14kQwUoKUB5Gizrc/L2TxtYmCpE6W7j0ny4T
	50Nc/1ba52TeU3JuOZncr20lRNwe6RwhGDMafolaRrizZ8ju3h5njNyK/7ULpYH+TMmuurtqDNa
	HBQIspHHNfxYeva1raBHKuvLwinhB7h5Yqz+Hq1/ihCli+lPCzjhS2lh26ba68mTtjeawB4gDcq
	8RBXjVsIIBLKyplGgxiUybfIhorVijF4SG1b1k4fLM6T/oo7p2QoM8rCkcUzV5zcE7yTX7ms+Ik
	FhkuT/enRnlbLfN9QP2aDPLv3teSC39ZwB8gyCjDGw==
X-Received: by 2002:a5d:5848:0:b0:487:27f6:a4dc with SMTP id ffacd0b85a97d-48727f6a6bdmr12398341f8f.44.1790071803547;
        Tue, 22 Sep 2026 03:10:03 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862785a4fsm4002024f8f.24.2026.09.22.03.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 03:10:03 -0700 (PDT)
Message-ID: <90812e76-fc01-409e-8156-ef958717218f@suse.com>
Date: Tue, 22 Sep 2026 12:10:00 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] module: Limit ELF includes in linux/module.h to
 uapi/linux/elf.h
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 4:40 PM, Petr Pavlu wrote:
> linux/module.h appears in roughly 15k #include directives across the
> kernel. This makes it a "hot" header, so it should avoid pulling in
> unnecessary definitions.
> 
> The header currently includes linux/elf.h but this is largely unnecessary
> because it requires only the base ELF structures, such as Elf_Ehdr and
> Elf_Sym, which are declared in uapi/linux/elf.h.
> 
> Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
> including linux/module.h alone results in 2.2 MB of preprocessed data. This
> change reduces that to 1.5 MB.
> 
> The first five patches are cleanups to avoid relying on declarations being
> indirectly provided through linux/module.h -> linux/elf.h. These patches
> are mostly independent and can go through their respective trees if
> preferred, except for the cpufeature patch, which depends on the preceding
> s390 cleanup. The final module patch depends on all of these changes.
> 
> It is hard to identify all files that indirectly reference something only
> through linux/module.h -> linux/elf.h. The changes were build-tested with
> allmodconfig on arm, arm64, m68k, mips, powerpc64, riscv, s390, x86_64.

I plan to pick up this series on modules-next by the end of the week.
Acked-by tags from the relevant maintainers would be appreciated.

-- 
Thanks,
Petr
