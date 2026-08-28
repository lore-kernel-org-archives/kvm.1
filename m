Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758303F107F
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879517; cv=none; b=UB9q96oVWrblu2mtBZg8556BTNlZDeI9f2wRE2xonnraiD2qMvK0klopyUvc0uG27Ie5UEGynmKboDDKcZosHeSpbSSmVP6WrcfQBfAl0rYKIuhYpo6ZSB+7O3G0r/avHA+Hhe0NkHmxYRWUdxVOlMRObHx/tyNW0FetdAkQlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879517; c=relaxed/simple;
	bh=t+wJTm0dr2TITZgkJPw63VxYmtoYNM0FqDrni6dFzX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGreiOtx7/9ihlrTv4v7QDXrRShxsiYnfKTeU2VYd9xOqyDslNdGxT4OBv6zwALqtMAcZ8f/5XjRnU6+zvpJhwv5or6MPLnCYP6GGY95CfP9WglKQwh0dFY75WIEFgLLpxGFQKVbExgnbsb1W34IpP0fqTkzoLqkuvsBWTTolIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nQcA2b1F; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nQcA2b1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nyiNkCWpBVpXnKDSw2YKvZCqSbJo0SjW2Z75TaY4a5g=;
	b=nQcA2b1F3xHcScVEni3k1LLuOEVYF1mcLzxHw70t/GE3A0UcpdHZoLY64+0zRM
	xJFGt3bLhnBe83ZIaBjHaKKNwUZ7oWl/eCUjXlwCq1QzGUTqFZr1A9p0+K4iISwO
	luofN9oY/oN/+bQCzsWK4+FZ2gDa3jIbGY1l7vWV+xCVU=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHKNxD4JBqebxmOg--.64138S2;
	Fri, 28 Aug 2026 09:11:31 +0800 (CST)
Date: Fri, 28 Aug 2026 09:11:30 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Hao Zhang <hao_zhang_kdev@163.com>, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: nSVM: Restore L1's debug registers on nested
 VM-Exit
Message-ID: <apDgQmZiieX9mCft@192.168.1.215>
References: <ao_Ms5alWwKa30U8@192.168.1.215>
 <apA-9UEveHuHhKkV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apA-9UEveHuHhKkV@google.com>
X-CM-TRANSID:PygvCgDHKNxD4JBqebxmOg--.64138S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKr4fGrykJr1DuF18Aw43Wrg_yoW8JF45p3
	srA3W2yF4DWr18KFZ7Ww1UXFy3Cw4rtrWUWr95Jw1ava1rGr93WF1IqFWj9FZrGFs5W3yY
	vF1DW348uayDtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUS388UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+gMH+WqQ4EMcGAAA3a

On Thu, Aug 27, 2026, Sean Christopherson wrote:
> On Thu, Aug 27, 2026, Hao Zhang wrote:
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > 
> > Restore L1's DR6 and DR7 when emulating a nested VM-Exit from L2 to L1.
> > KVM loads L2's debug register state from vmcb12 on nested VMRUN, but
> > currently restores DR7 to its reset value and leaves DR6 untouched when
> > switching back to vmcb01.  As a result, L1 can observe stale L2 DR6 state
> > and lose its DR7 state after an L2 VM-Exit.
> 
> Well, yeah, because the APM says so.  The APM very clearly says:
> 
>   Disables all breakpoints in the host DR7 register.
> 
> In typical APM fashion, it says nothing about DR6, so it's reasonable to assume
> it's preserved as-is across #VMEXIT, i.e. is L1's responsibility to ignore since
> there's no #DB.
>
Thanks. I checked the APM which requires #VMEXIT disables all breakpoints in
the host DR7 register, which means KVM's DR7_FIXED_1 restore on nested VM-Exit 
is intentional architectural behavior for L1-as-host, not a lost-state bug.

I'll drop this patch as-is.

Thanks,
Hao
> > Restore both registers from vmcb01, matching the rest of the L1 processor
> > state restored on nested VM-Exit.
> 
> What happens to other state is irrelevant, what matters is what the architecture
> says happens.

