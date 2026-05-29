Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D28D30568E;
	Fri, 29 May 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053733; cv=none; b=W2dKDm+xFzbF2eWIVBfUPA7ljQ8JC2QT/SZzI2eiSlLUs3rf0SaN406v5YnkTT+6sRw3vBnIyhQgirV3ATLL/hU0Lny/WUFLaBKL+rRFIYnqJYJF7y0SsJTbjVG/0F68tE5YmAVJM72nlnGZIU7bCGCRfGQ+MHzuHmWIE6IGVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053733; c=relaxed/simple;
	bh=feldwm6Q/Y+x+bPS923hGc77SAJ+PAtGJb9scAMH0Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcZ56I/qfYmNO3t+4qoga9d0rFgW61VMB8pPIRl7zS+MKPfQg4xS8EJIr0iSbegP+5QpWtMglr5K/bdOYZqF4AbUkBNeqNXjghAhZQFfT7KS3GmCkZNFLf4BA3VY3wfYmOoTAmFc05LbAVNfAaexhDlMfQuE+dGqT497UnuSuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsJXfQ44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsJXfQ44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976BE1F00898;
	Fri, 29 May 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053731;
	bh=KgEJPRGp8D+3qeCbLvSeLHce5Kj7KlJmFTZAlm3GB6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QsJXfQ44kralTPQpmeces5nTawioQFFUeeRlPYWgxdUXENJNdQqqhIn0j9MalXTZb
	 k8oJS5Ipr1Drqd2AJ3kSB8PPTlLxUYHjOwIOkWPpFXZWvfXFDcu0h6z2La+MDySHMc
	 phOuA8ms0ijqAjas2CM83w96pYVoGlt7+1JfdrYOSfUmnG6ag1nGs7gtYq7bnqWsJI
	 PkmiZsEFAeALCkKNMMDH9VdDvemEu3P8FF8tRWNOBTx3MuqY7CNjaGjpX4+X2i9BoC
	 PZgFh/sM3BQfJiiEknGDbgvry7rHudyHxSI8IIQbrpCZNahJwW3TxfE0qNbWtN800J
	 lzf6rH9lSaJ8w==
Date: Fri, 29 May 2026 07:22:10 -0400
From: Sasha Levin <sashal@kernel.org>
To: Bjoern Doebel <doebel@amazon.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>, stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to
 unexpected GFN
Message-ID: <ahl24spfnGbMs3OC@laps>
References: <20260505070812.221568-1-pbonzini@redhat.com>
 <20260509122858.475f3b407568.re-kvm-x86-shadow-paging-uaf-6.1@kernel.org>
 <ahlQ/m2bMK0yEYfQ@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ahlQ/m2bMK0yEYfQ@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>

On Fri, May 29, 2026 at 08:40:47AM +0000, Bjoern Doebel wrote:
>Hi Sasha,
>
>On Sat, May 09, 2026 at 08:46:50AM -0400, Sasha Levin wrote:
>> > [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
>>
>> Queued for 6.1.y, thanks.
>
>As I don't see that commit on the stable/linux-6.1.y branch, did this perhaps
>get lost in the frenzy of the last weeks?

It's still queued up. There was no release of 6.1 just yet.

-- 
Thanks,
Sasha
