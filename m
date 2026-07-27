Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89F3CAE95;
	Mon, 27 Jul 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180186; cv=none; b=Zj0X2oTkikhrrIsKVMziU35DYCLDzOCL94zDQ5OXGVRdN4DSnq0cFKzaPrNy19o+R7y6K1+prMd2Uj6tZ9f2KrdaPM1SKu6xm6ATIDC2J5XAxzHfsHdTowc9M+YRsj5gGTVQAAEZhGo0/zkd9hAnE0Y1Kr9hjabTxn+dc9epnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180186; c=relaxed/simple;
	bh=upnec2ANzp94Bia+Qe1bB+uPBX7RoQGbn2Kl+1MTG00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUF5/HEtbe5WOKJ43KDT2YSZh6KHWDUxusIJa0QK+ndozXje7F5lqP0aTkkrnmgzQkqxDT9TaSfx5Ak+lmK7qZcKz4HvUzM0yQoiDNF+oOsR4688DOS3SveeDFgG6jTBN2iWixYQlP/A/hNI0WMnzK3sEzvrgQiz5UHeFidThsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG2f5n4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG2f5n4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84021F00A3D;
	Mon, 27 Jul 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180185;
	bh=CK98w2897Q+Lm211n00uhm0i+Qs+H0hzEDg/y7ELT0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CG2f5n4VmnFtxujEIzHUTm3oj8q+x9aonEY14gF6KQ4EqKDtkyvoihnpLJ1QRAz56
	 0pGYGVZsrqxlbTh+vNMvOjvzvwXYiubas8PSuXK1+klmPs2oOybzfDDWdKl0trmwto
	 DKYdRg8qjMk1bNchM6MyBMR9KP6KRI2+Y+KsovMUw7r7ae0bpB3MM4L3pyECs8et/I
	 TOQ5yfjjD9WD9JwA5algaJrxaHy8MjILf0JeE04ZPfqNPya9L5bIPKd5radWP2G1wf
	 6Icb9PkBhGnoApD/a+VEouuAB9YC//FDuoMKIDZwE6/mrxtHqYDXwq58Br+m48G8ma
	 8pjhSwyg7lv+Q==
Date: Mon, 27 Jul 2026 13:23:03 -0600
From: Tycho Andersen <tycho@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
Message-ID: <ameuTMWJUZfleIbk@tycho.pizza>
References: <20260723094419.630204-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723094419.630204-1-pbonzini@redhat.com>

Hi all,

On Thu, Jul 23, 2026 at 11:44:19AM +0200, Paolo Bonzini wrote:
> As to the workload, Alexander threw more or less everything at the same
> time at the VM:
> 
> - a full Windows Defender scan every 30 minutes
> 
> - a disk I/O job
> 
> - a loop doing repeated mmap of system files (mostly to hope that
>   it triggers some consistency check in the Windows memory manager)
> 
> - SQL Express 2022 + StressDB (1.6M rows), with the host doing queries
>   (75% write/25% read) via sqlcmd

Can you share the code for the mmap + disk io + DB content generator?

We're looking at this and would like to reproduce.

Thanks,

Tycho
