Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430843B484;
	Thu, 13 Aug 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614977; cv=none; b=SV22mR70+UR/7M/dejWaErdSNgnRAZqMtsPf/rkWMVX/UW7juk7bQBFy0htXzcLRZC2b4LHx3RObSBLQypCckdK3vw6KT8SoYCtniedR18ajIRuvZg01MuOUJL/7SVDLrDxHeUEn6rCT7gi/d2yL9WCHhwZUIIKw8TsG905DccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614977; c=relaxed/simple;
	bh=fe0PiI0tbje7mDQnllJuS4c/X9G4EFtqdWpnUoEflmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPWlt1Lr5XbfVLCF1fnR8QZ0vmVP9ga8f0PLMBR/SedFx5KVKcrBbLk6DyQSoD9hl7jWVH2rhyAwgZhDF++dvEt/qXxErFsIVdfF1BBdSgqM8KOWE6nivIKnEJCl+mbwPEBLGNTCS/80fLJUqKZ0xE/Kvt+nP0yCZ1oZYSZCe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7Rq7ka4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7Rq7ka4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A831F000E9;
	Thu, 13 Aug 2026 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614976;
	bh=tZpZjc7lV7hex9a/WMSkgBgO3Uo0E+LaPx8CBfGeU9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f7Rq7ka4mPVQpbSNU4DEA3OBqJs1OcMFrBGQBuqMbzMCuQ4rAf+xp4cNNSSug/WtB
	 WItV6JKLN3JzDHJNKJDwokANQXZ9lLcfscMEiu0US5eE8z7WnZtVF1BFjzLaE4DjHB
	 I+J9EPImAtZ/eZ3gNdezczlizm7gpSLexTnZBCnHXC9MctvN3xj3pRwE/eSs9f9syP
	 vELeURe+XOPI4P7lj/QctE8FUFJONbPgP7YawkNZbGaM42mGvjtrwdiSY+sAFsAyrw
	 gc60F5Ur3c19PiApN2r0R3wJlh60mlhsBHBCNFggdRKG41YlApJfcGzpY8joz6W9kg
	 WQwXsRkz1Ottw==
Message-ID: <3086e4a1-58c4-461d-909e-d31671a4eb4c@kernel.org>
Date: Thu, 13 Aug 2026 11:56:11 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS : Add myself as reviewer for PPC KVM
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20251103094243.57593-1-gautam@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20251103094243.57593-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/11/2025 à 10:42, Gautam Menghani a écrit :
> I have been contributing to PPC KVM for sometime now and would like to get
> notified of incoming changes to help with code reviews as well.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..3f2f60486222 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13701,6 +13701,7 @@ F:	arch/mips/kvm/
>   KERNEL VIRTUAL MACHINE FOR POWERPC (KVM/powerpc)
>   M:	Madhavan Srinivasan <maddy@linux.ibm.com>
>   R:	Nicholas Piggin <npiggin@gmail.com>
> +R:	Gautam Menghani <gautam@linux.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   L:	kvm@vger.kernel.org
>   S:	Maintained (Book3S 64-bit HV)

