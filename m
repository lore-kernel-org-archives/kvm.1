Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEF3AA50B;
	Mon, 20 Apr 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691285; cv=none; b=mOQ9S0lyUUevMCzd2k5fXrFn5Mogpp6+Mrc3OCaNnW5Av97Z6VYwx9FHQNxV4BCDJlnCXQMlEXN+q9auh74OhG6sbJCCKeaKpm2RqLqiLmpNVahFkI+DJA1+mQGpKSG1i84xCrzb0LVFmra4ezXicYfO6/nxe3IVjELDTdtr8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691285; c=relaxed/simple;
	bh=irXKbDxR4R/RMQ/RUVRgmZ3YZbGAdzFMXqwKXU6V2qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq0hQ4Bwrtu+2sMQyeY62BvFcEAyGevsZf0+44a7XIdIxHLFEamvdY/B+005nvYTPMuYbchtiWwyd5RviC3XoSaUvs/eAy2vLA+JqiLbSDj3ZgcFlD90HLGhUZFjzZsefp2UuYp/1gA9oFd7rZQ3sip2Vi8DSODP276jlFyNT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smf2Wske; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smf2Wske"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E6FC2BCB7;
	Mon, 20 Apr 2026 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691285;
	bh=irXKbDxR4R/RMQ/RUVRgmZ3YZbGAdzFMXqwKXU6V2qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smf2WskeroHlzBQKKrIbCMEeVafgAVANKuPMUPxCEglnLaweCuTLHVcU/d1/3IGLT
	 aLUPh4Piy7x1RJNvTLNtgl9TsrY80Cls4R1/s9IwsWk08vm9QHbGna+3WRMiUKFLCI
	 Luvf+J7Mi8KLO6yC7KIsHMlNRRAAHjZhYA/mHrTGlHt0tOuFcMfdZEz9wFE65TNwTw
	 eXEkI65khwGXjJ6Jwj/2ExoMPmE3BXroSpwd7eWwfcDuGXmV214ERcb78N05QGOsVf
	 6QnK2MZvUkzDXFXYYdLkYItIQHjckzja05Jc9zHLVQk+fImYLrdmP0xE26YHIm5lJy
	 0NceNGQ4/obXQ==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.6] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
Date: Mon, 20 Apr 2026 09:21:06 -0400
Message-ID: <20260420-stable-reply-kvm-nvmx-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202346.3026288-1-seanjc@google.com>
References: <20260415202346.3026288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Apr 15, 2026, Sean Christopherson wrote:
> Backport of 321ef62b0c5f ("KVM: nVMX: Fold requested virtual interrupt
> check into has_nested_events()") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha
