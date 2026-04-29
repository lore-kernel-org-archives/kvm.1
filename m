Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB83FE668
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479255; cv=none; b=JFneCBmIccYrkyq+7CpfwBZgfi8uZOWleZmlHS1GTJexKvfAIOaBea9jlq04E3KjfOjjwG6eyXIswpnMjWuVtGGfShbdPDnz2QDBv2SU4qHGjEgb49qk0EMs/EwaS9cQtYNyDO7hGgRI+LyJenbVGz0qwTAKbcsaPrHEdQNU7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479255; c=relaxed/simple;
	bh=QIUvdq75lFARum0k0kDOdaUv3IFA90teUppVmMvzJ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JusQpptxsrKUUUBGaLsoh47wbG0PTRRsRbHVVEOmSRIr6f5IodXvbFWrzf4IGDjS2ZEGRxjPTUGL1nB8vJEE/tQcxHb0PuMWBD8mhYnpPZjj56ZC6X2bmgNbz7zmxEqjmaxbTXOHacLhKnVCkdp4aeVY5aREYS4ciSuqhfOGQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=P6gaUGVt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="P6gaUGVt"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ef0ba61d46so1009796085a.2
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777479238; x=1778084038; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQwXlv6d4SrpAwunOCAy3T3SkF7dwQSFYcS5dAIRLRw=;
        b=P6gaUGVt4DL4MaxesXHAsm1WRtPsjCE96KoMA806ZhpJiTxloitgveQ6S0W55/jAjC
         m3xxc6ak3Jv6S8Bac6jq2JH5eoiHQjs99UvHkqo8TozdXj0yIfYVjvdXKD2/kbyzB+5K
         D7Dh30hlJhrvxm0dpoeovS6qcPrvH6gAg2gv4OyCX+5FievTIubmsiKHRK9VQ21+iYuw
         /jQ6Xp5ZBhrYWFehn640+I0NoF4HVMYVF0HewxvqKQ4Qn2HIZN7MFCctg939Yv4nTsVo
         8XyqtjG+lf8RBaPcYt0oz4LjY2sM5DHZXLlHauQl9nfuHhdhdhIRVIOWZpt/o3/of3Tj
         XyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479238; x=1778084038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQwXlv6d4SrpAwunOCAy3T3SkF7dwQSFYcS5dAIRLRw=;
        b=cAxc4mvgtsqZfoqMdaHn9C+BRzh2aKA9FrFKWnOqM8d3tEv01MYrLpfidBvRUkZJ/e
         ystjiNBSvS1S0vTsIgIBbgu54RC/RnbdLbtOGH3xu43U9csGK90GwnUdxUOI4lG+8sf1
         QJbKXlHeWru1ydr6lmq8D6L7kkpJL/dAU2NpRlinSgYpuO/LVa3naPfhJJ+TQRLn2Z/9
         zTbBDxur7cSxefP5sTGMfSe273bYaJFoYu8JxbUJFaA/O0/xHYDIU5QCLGyakLOYob2d
         zKIa7y32yTBMlh+MeB4ne1z0NkhLU0le+EPUxkreseiF8mOE1bCD4uKgcEoAqeBrA8ek
         36TA==
X-Forwarded-Encrypted: i=1; AFNElJ8fM8cWqK4thSJakjErlJesUzydihKoaK4ZZXCp/3YS1hhn3gbzOiN39XTzjRs/g6/oqUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzahUfSdZj8+v/1Z+YaK890dyb56vWncVGYZuXTRuJcXrPKsEvJ
	2k5bp+OStH0/Udzg8N+IYzdMlBor2PpIMR3270ifJ1GT/UqBjA/uUmErAPN+pvbwprg=
X-Gm-Gg: AeBDieuVvGY66AnW50uPgmKj9OHFfT3WGa6I255cAMkNy250ZZlIirIi1I7kWvEIZye
	Dc2Tc5wAtcd5mRjx1+kjqXna4DdibYeesBnurhe6TBthAJxU6VQjvC3G0xX6gAy494iBOx+1W/1
	HvXu+forKDBsrM70GHf4X0tTKv4AcN5+CMVC1d8jREs4C4w+MN/GffLI9Lrb+u7ymgVOgW4Xk+s
	a50gYNC4Zi+K7zgZpnoc7cumd73tQTVOZZJ/Gde5NXHr8NtCx26k5erfvGUwIkjC0/P1MAt75+o
	Fnh9c9mCdigzQ3V+O9fQXHa5gT3llBhqL04B/zvnlh1pUaCerpNCtZrHdO0yzc291VAkOlyt033
	N9zhn0x+LEI59ych/nxkATHc6VFHCJLuN2wEgcNYgtIGFfbRJWUeJjOlq+V1Jqg9AcS/aySibdU
	1x+8u935PJQehCyv8/sLngCDuGL43OjZXx7xNzZpX0vtTirjIqDBn8wdIpNoNPuGQU0sb4XeiS
X-Received: by 2002:a05:620a:472b:b0:8cd:9033:172a with SMTP id af79cd13be357-8f8f3a204a5mr643580085a.3.1777479238360;
        Wed, 29 Apr 2026 09:13:58 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f5826f7sm235640585a.30.2026.04.29.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:13:57 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:13:55 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alexander Graf <graf@amazon.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.linux.dev, rppt@kernel.org, 
	pratyush@kernel.org, pbonzini@redhat.com, seanjc@google.com, maz@kernel.org, 
	oupton@kernel.org, alex.williamson@redhat.com, kevin.tian@intel.com, 
	rientjes@google.com, Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, 
	baolu.lu@linux.intel.com, david@kernel.org, dmatlack@google.com, mheyne@amazon.de, 
	jgowans@amazon.com, jgg@nvidia.com, pankaj.gupta.linux@gmail.com, 
	kpraveen.lkml@gmail.com, vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	loeser@linux.microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, roman.gushchin@linux.dev, 
	akpm@linux-foundation.org, pjt@google.com, "Petrongonas, Evangelos" <epetron@amazon.de>, 
	kpsingh@kernel.org, jackmanb@google.com
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
Message-ID: <afIru_PE3W0hIsu7@plex>
References: <afEwWZksU0Fw61oT@plex>
 <b52e7d0a-4275-48a0-850f-6ceccfd5204e@amazon.com>
 <cd0ae5795cf14a7b20c90840b0a3eba7db160e72.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd0ae5795cf14a7b20c90840b0a3eba7db160e72.camel@infradead.org>

On 04-29 09:40, David Woodhouse wrote:
> On Wed, 2026-04-29 at 10:13 +0200, Alexander Graf wrote:
> > I would prefer we only attach the whole caretaker and all of its 
> > specialties right around the point when live update happens. Why keep it 
> > dangling and active forever? That way you can also late load the kernel 
> > module that contains it, so you can be sure it's an up to date version.
> 
> "Why keep it dangling and active forever?"
> 
> I've always wanted to tie this to address space isolation.
> 
> The only way to truly stay in front of the constant stream of new
> speculation vulnerabilities has been to just make sure there's nothing
> sensitive accessible in the address space at all. Hence all the work on
> secret hiding, XPFO, proclocal, etc. — and hence the occasional
> researcher finding their shiny new (5-year-old) vulnerability and being
> confused when it doesn't leak anything *interesting* in certain
> environments.
> 
> I'd like to see the inner KVM_RUN loop switch to a completely separate
> address space, in which there's a kind of caretaker which can handle
> the bare minimum of interrupts and timers and the most common exits,
> and which *relatively* rarely has to come back into the real Linux
> address space.
> 
> And once you have that caretaker running in its own address space...
> why not just let it keep going while Linux does its kexec?

Yep, this captures one of the benefits of having a permanently attached
Caretaker.

By establishing that isolated execution environment for the inner
KVM_RUN loop to mitigate speculation vulnerabilities, we naturally get
the hardware-enforced boundary required to survive the kexec gap. The
Live Update capability is effectively a byproduct of achieving true
Address Space Isolation.

+CC KP and Brendan
