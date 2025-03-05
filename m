Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC33C2ED;
	Wed,  5 Mar 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184378; cv=none; b=OFiEzB2eaNtmZZ2f+JI1TO0jlNgAs/S9qZEgKd/7ofS96LzvP7kiNkmKf/zG5i7W7c50EsyBOwzGHLznhmbtSVpjKbSuLLd3Jw2DDilD6NfxnaLdjtlmMSDJdx8KyDN9F0pDsYb7wWuQYc6H5IB8gykvOjhqXEUTndYn952DapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184378; c=relaxed/simple;
	bh=gr6AIeXrk7toPGAq+EGWNUJ0Rw7W7akc2JJ+IpSibI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs/HiufShxJq+v52oxtOEyBgr6/A5tH1v8avj18BzJSS18hC+55HKW1dtrk6G7iYSNXxt9FVP1XhdiYNST0k3/dObVMIm6Ngr9/yKlZHlh+enHHqtedCa9C/xfZnkaday6XQxUSWXFem3WLnt9VONmfGwyI3Lu0NRjS+8rlBev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UrBVaWeh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UrBVaWeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6369AC4CED1;
	Wed,  5 Mar 2025 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741184377;
	bh=gr6AIeXrk7toPGAq+EGWNUJ0Rw7W7akc2JJ+IpSibI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrBVaWeh9cfCtfWfG18L68fypcEi903bh0aPiIChrvDZSVFkRCr0f1OjIAcKV0N+1
	 duWvo5UZCKKtuYLkZlwuaKsIrDUiGNUwH0Efag8nmJbwWIljutcLPU+vVvxYEWm4Pu
	 aG0er/6DeoXPi3aEL8DJsABdU5SIQr6LqILPBjzM=
Date: Wed, 5 Mar 2025 15:19:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, seanjc@google.com,
	linuxppc-dev@lists.ozlabs.org, regressions@lists.linux.dev,
	Trevor Dickinson <rtd2@xtra.co.nz>,
	mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>
Subject: Re: [Kernel 6.12.17] [PowerPC e5500] KVM HV compilation error
Message-ID: <2025030516-scoured-ethanol-6540@gregkh>
References: <20250112095527.434998-4-pbonzini@redhat.com>
 <DDEA8D1B-0A0F-4CF3-9A73-7762FFEFD166@xenosoft.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDEA8D1B-0A0F-4CF3-9A73-7762FFEFD166@xenosoft.de>

On Wed, Mar 05, 2025 at 03:14:13PM +0100, Christian Zigotzky wrote:
> Hi All,
> 
> The stable long-term kernel 6.12.17 cannot compile with KVM HV support for e5500 PowerPC machines anymore.
> 
> Bug report: https://github.com/chzigotzky/kernels/issues/6
> 
> Kernel config: https://github.com/chzigotzky/kernels/blob/6_12/configs/x5000_defconfig
> 
> Error messages:
> 
> arch/powerpc/kvm/e500_mmu_host.c: In function 'kvmppc_e500_shadow_map':
> arch/powerpc/kvm/e500_mmu_host.c:447:9: error: implicit declaration of function '__kvm_faultin_pfn' [-Werror=implicit-function-declaration]
>    pfn = __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, NULL, &page);
>          ^~~~~~~~~~~~~~~~~
>   CC      kernel/notifier.o
> arch/powerpc/kvm/e500_mmu_host.c:500:2: error: implicit declaration of function 'kvm_release_faultin_page'; did you mean 'kvm_read_guest_page'? [-Werror=implicit-function-declaration]
>   kvm_release_faultin_page(kvm, page, !!ret, writable);
> 
> After that, I compiled it without KVM HV support.
> 
> Kernel config: https://github.com/chzigotzky/kernels/blob/6_12/configs/e5500_defconfig
> 
> Please check the error messages.

Odd, what commit caused this problem?  Any hint as to what commit is
missing to fix it?

thanks,

greg k-h
