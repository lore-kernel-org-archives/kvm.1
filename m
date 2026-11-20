Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200859;
	b=Uegq2OLS8gfqiZh5iUOUFEKRFltd1uyCWdvEqvIYHVyDAEPVaLDPLs21ozVlPwUwaG/+
	 ttEkyNl4pE6Uwm4xZuke6vpvdtugKi288027vxhtNysQzrR9Cp9ehWU7TCcc1QTKQsh04
	 ZMhMakCy+szEKbAK/2VXqz0g1x2WI0vyN9IQd+yma+Ik/AoiQ8WOMxUKUPbU2Lej8ceu/
	 8M0bgSlOCYwaI3aRlguessLcb3ETNxlsEibRZllzQ/oFZFTqYMjDmQD5+M6RicrGDzFVp
	 jyMqrC9n8O05mm3QtMBHlhB7PQ/rHtDSBzYPMshICrthT42wdkDmufY5Snys9j2WAig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2cDvgzaEPEJPCI6Ok0IK34cIag8JscyuYpBaCTCvSvo=;
	b=Z9xOMqbSqkH3o2q4tNky9vM4HYQByltksMUfe/FmfVGNxs3UXMlAhKsqEDMkPYdLU4/B
	 IllIcbLCtXn0wpI4Cv5o91r2gyvh1fYv9crVvRYlKraddTo+tsSXFtL7ATmw1M27+xeIw
	 ShbRLhn+LyxH6I5XUZrn4OxmRTXNnMZ4sPSGYzMlR31XxSCiia0d6GpHi65pPpGsse4KD
	 ihXjmMSw0MHVTIng7eIs/ZpT+MRXeCzoatr8WTmLD3eLXeWyO4bN5sYhbIwOvLTsh/rvf
	 4sPVEJ+JVrm81a/H4T7hRH4TK/qYiqMkhcFT/neD60Buu6HBP3LjrL9YRI0odA+MRbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PxUyExOQ;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8260A2620
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 18:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C8260A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PxUyExOQ
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-94960131b30so133472785a.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795200857; x=1795805657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cDvgzaEPEJPCI6Ok0IK34cIag8JscyuYpBaCTCvSvo=;
        b=PxUyExOQamKrAoNEpUWtU2MH9fyiBoDE+oyzzWlBCvln/cdtZhzS8I5kFGTGU8UK4s
         VqHhE4Vt2QC0JD6xKAIKBwlckOueByn4Mi0ughCh4Nrr229Xl1hXBMSAbxW+HnaEcLpD
         grrx6A8C/3YbVNUlOircjbOUQgbWr/s5ei3yo9JC4HsqqHqSe3sommFF/pddgnoIDw5G
         krk8Ra0WyE6At2RXi2ZH5L+qfuBkTL1hQltq2S+R6I/WEuaVAF46YIMp0l1MdHmRy965
         7QtohddcDJfzDDOAFJQqDK3KgIG6fgcaNRwuZ4TkNb84VQdsz9mOMj6HyiNGOGMNenPq
         r5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795200857; x=1795805657;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cDvgzaEPEJPCI6Ok0IK34cIag8JscyuYpBaCTCvSvo=;
        b=zolVlSsSj98QfCmUTSoo/sGRZMR2vekvPIn+XBNQqWg2bUxCQ8bMY+P3ta7lN3jri2
         bV5bzNErigaqSiKNBst5fTIqEs+9JUVRG2kiRpn7eaZmVfeTr4mI356D0vJO5pRkoLc+
         gmEDuAIc8do7jtc9j1TbI3DOhuE21xajgB/zJt+G6rqVz4VL9RbhnHGr+9YoWJQv5x0/
         qdNQdnFRoinXZ/uV56XCkZZ9lLAOEYJPpYJbR6bWjuJpY8GazX+M/RnbFdgxoPARAwRG
         F6NTbqpa5g36m9Y7H5C2CM6wquO+Uj3zt+kzr/YkW8XTSPPiQwaKMLod57Bd2O7ob32M
         LhFA==
X-Forwarded-Encrypted: i=1; AL+hErGWtrAqAKV7HYzG6husgXjExbOOePikuSzeKwUzMTDI8ipZWj8wSspN7Stv18TkNPfBbiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1AaUYZ7f+alEHW+eu0bNCNsnXnIqt/FxGmYaIXBpaNdpYscZZ
	fLB38MwdBMzbGLHUSEQNHVJ8bUtlKPeQN6T4VSeWhQp8Fm/VMol0p5g2vC3cqy9cHYw=
X-Gm-Gg: AYBFou12NPZEi4ipa7qkutJ+NDOfkE3fZkmsiTdq9VJqIe8OHkSkClhx5O8BK3q2l6e
	/HYg7Fha+uMe/4uFWkF2UjmMgBHGfH7yYu28Y3PBhg8AV+XeI/SHMFG7Xyf73p43roRB0B2+XbM
	frr2bOF0xcJEadfhynhFrTyoY04HWwAnRPMj/M1JyTV3zroLVtMSH/RfFa1gPGHVxDI9B9mjaCe
	hZCIFmghxasCUgIO7RrLOxrnv4cAHSULcwbgzYJKwtFYGLTGcYRIiH3lX2qf47EtHWpmaXwopXF
	6yaiiKj69jSMupi24qhjo3IcbNCDPFx115wiXsoovAXbrTEFg/mENnJWw4CYzkwjdgZWO8sZD4G
	/tDj4OFlJNsaU1YSDbWiZBiYItPRkqPDhmbS9BUKdgHb81rEROmAGo36cZJkEKL0VdDgr63cqqT
	ISLBK5ORjmBuZzxnHSHx7fhoYOa+NaZZz14Ru/9SmO7rnUoaSXMRtut5f74+dS9Clw7pATITdkn
	1gk+ErSkcTeKfMZ4pAYC7vLk8ikaHjOMYVGgkwlgv29GLzInB1Kre+Q5fY6nYx71WVBRxecGNV0
	enzpVw==
X-Received: by 2002:a05:620a:7008:b0:949:5fee:afc6 with SMTP id af79cd13be357-949baa07369mr665380885a.63.1795200857416;
        Fri, 20 Nov 2026 10:54:17 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm256798785a.17.2026.11.20.10.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:54:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUTkV-00000004ls7-3duu;
	Fri, 20 Nov 2026 14:54:15 -0400
Date: Fri, 20 Nov 2026 14:54:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, alex@shazbot.org, den@openvz.org,
	khorenko@virtuozzo.com
Subject: Re: [PATCH 0/1] vfio: fix KVM reference leak on QEMU CPR
Message-ID: <20261120185415.GA1133597@ziepe.ca>
References: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
 <1075a283-b745-418b-b49a-2dfd41faba3b@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075a283-b745-418b-b49a-2dfd41faba3b@redhat.com>

On Fri, Nov 20, 2026 at 05:52:09PM +0100, Paolo Bonzini wrote:
> On 11/20/26 16:47, Andrey Drobyshev wrote:
> > When a VM has a VFIO device and QEMU does a CPR (CheckPoint and Restart)
> > live update, QEMU creates a new VM and keeps the device open.  The
> > device holds a reference to the VM it was opened with, so the old VM is
> > not destroyed.  It stays until the device is closed, which usually means
> > for as long as the guest runs.
> > 
> > It is one stale VM, not one per update.  It is also visible: after
> > cpr-exec the kernel logs "kvm: debugfs: duplicate directory <pid>-<fd>",
> > and the new VM gets no debugfs directory.
> > 
> > This patch makes the device take that reference only if its driver uses
> > it.
> 
> There are two problems with this patch:
> 
> 1) It sweeps the bug under the carpet and only solves the case that *you*
> care about.  If the device keeps a reference to the VM it was first bound
> to, the problem is that there's no handoff from the old file descriptor to
> the new one.

Yeah, reflowing the kvm fd is not something vfio broadly supports at
all, there a several issues with even trying to do this this I think.

If qemu is doing a live update it probably has to keep the kvm fd
alive across the update too..

Ie when we get to things like confidential VMs there is state inside
that the kvm FD that cannot be checkpointed.

Jason
