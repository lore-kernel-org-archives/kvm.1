Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AC35F170
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493821; cv=none; b=XnqZKQhXyjqXmYkGG3cgMoU+FuC6tut/A/oabI1RkUzqoAnQK1TO9x3HZQruxjEqNOI+g/Egsc0VpX6Uh62wRPuo7R64ySTot1uDHpNZVz03A9MnyROAXVwx/DcGCB9rDH/lhBXK3gXHyaXUYWPUUaJmYgwZ4zbM4KviLY8UHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493821; c=relaxed/simple;
	bh=70juYxIUdAmmDC/kCtJdEbKBZyXEA5lwVJTQ2r2IwhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/M+IaludxnHv36L6jazouqXU4jU5+rX48vne/2j4m6aMoqvAVPvlstiSDBusr0AQO9CbxzQly5ccz58qgdUyudA23e3TeTjQlMqLS5nYz+Wws1ZvHI68yiHiHnonAsB3cI6FZ/PLDIn128tL3GLXmcZ5Kc0lDXHseIWgQduPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4Ufb0Vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4Ufb0Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923551F00A3F
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493820;
	bh=+7/LJADrQKRf5I/52L0O6RFJgB3HraO8VhuLuOw9b6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e4Ufb0VbOB50pWlk82zWq2rcyoj4m7/xri8WkpRatYCCQIi0ZcK8QB6KnxGa5we7n
	 AIoi6Ux7IT7munRnrV9ihBf4NHf92K2mTZb4xByehV/jqVcw43nGuZALDbl/2ty7WE
	 h02AQp+o0Q/mwZN/XP9Ea6SEflzfUYOq9V6FW3iOjRlBrJEvRev+p1u5q5haSx9Coc
	 orveHdx0/ak/u8VPjzGdEqTlw/yqq3NJOfdTTBPOxVZR5a3kRGbJlPu32R0kOqHwK0
	 ZNap9JE0KZP8lPVDCpBbqMUJNeZs5K83n8nEZ1lhhwsNyWb54ONPwT5RD+crHChUTf
	 U2Al/Rmg5kS3w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd22b2abaa4so1322889566b.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:50:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Nw76LtyzGuY6vRUlCdBJdLKYAQX0lc2zSCgDVm28J9B8swk6hTkshtC0ngIQM8nvexwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQIh7hic/IROWE/4JlsQHaL3ErbTIpJnXLcLQgqBqVNY3sm5p
	Dh5f0fwrTGoYX5pGF7wgCarJpe5fRs1xYS5sibReDumoSwj306e5XsJ/kMXghtcSJPwxSIR3rvP
	BPOeS47jv7avsnKbbnaxKtILoH0r7wew=
X-Received: by 2002:a17:907:a789:b0:baf:19a8:b44b with SMTP id
 a640c23a62f3a-bdd276ccf77mr393705466b.25.1779493819560; Fri, 22 May 2026
 16:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-7-6983ae4c3a4d@google.com>
 <CAO9r8zMY6i+TWoZPWzj8zB+Xw3rONbK-Nee1kSFwDkT3hy66zg@mail.gmail.com> <ahDhQJI7xBOQpnjg@google.com>
In-Reply-To: <ahDhQJI7xBOQpnjg@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 22 May 2026 16:50:07 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMaiGL8v=f72EAwWbwofoUHOkH8r6Se22k2TVxnUCQLOQ@mail.gmail.com>
X-Gm-Features: AVHnY4JqeJTUpgCJK6wBsGYftwqfsgN8XZ_oucWG29bLRQoRun4zGBsAHuwrKNA
Message-ID: <CAO9r8zMaiGL8v=f72EAwWbwofoUHOkH8r6Se22k2TVxnUCQLOQ@mail.gmail.com>
Subject: Re: [PATCH v13 07/22] KVM: selftests: Introduce structures for TDX
 guest boot parameters
To: Sean Christopherson <seanjc@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Sean, is this the preferred way to expose offsets to asm files (or asm
> > code blocks) -- as opposed to say using .equ [*]?
>
> For actual .S assembly, yes.  For inline asm, maybe?  If it looks prettier, go
> for it.
>
> > If yes, I can rework my nVMX GPR fixes to use the same approach for
> > register offsets. I wonder if the non-TDX part of this patch (i.e.
> > Makefile stuff) can be split, then patch 6 and the Makefile stuff can
> > land independently and allow development on top.
> >
> > I can also split them out and include them in the next version of my
> > series, then whichever series lands first will land the offsets
> > support.
> >
> > WDYT?
>
> Hmm, I'd say keep your series as-is for now.  The OFFSET() infrastructure really
> shines for proper assembly.  For what you're doing, AFAICT it's only marginally
> better.  So I don't think it's worth juggling dependencies to use it right away,
> we can always convert if/when the TDX series lands the fancy stuff.

Ack. We can do the switch later like you say.
