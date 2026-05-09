Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D75389105;
	Sat,  9 May 2026 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330845; cv=none; b=kz0/Hv+6We+Ayb9yeYWreBOTxEXUPwfdjBRStfhhshZEG3e3+9t7F4QQxpcsaY4KOIDXigI4l/uV8amGeILUJ2pCd0GIs8zyNzYhxPY3w2KiX1BjLlUHLkdQp1gqL7qsGNDkRXvtJ4bi2RJfZNt4XzH7DQY5iFgwbqLN40cYADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330845; c=relaxed/simple;
	bh=8E5cLeeujLpCwIDAGfrU5hbfbW/01QU2+pLw4doz9jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvZnms7VX7UOlEjzb1suPD7b8uiDiqlajG5YF8r1MYzUCYck6Bfp6KogCU8hBaHU5bcWDoCxEYaHJvkq8h6Af+xLRIs2Mj4PZnKdOx4ECoHODj8tf6D9lIQIYWGGAStggZIeVSMeeJrUUPmF+1qifFChLgkQrEo6JsMmopKbEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8HvroWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8HvroWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4E4C2BCC9;
	Sat,  9 May 2026 12:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330845;
	bh=8E5cLeeujLpCwIDAGfrU5hbfbW/01QU2+pLw4doz9jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8HvroWs71uc+qcEzo+ALeV+1iNKvgJBcJvm7q0YosgsLC4ruc7fh3OdTRwLKpSM8
	 0m1yxjKTnMqdTEMu/IPnY1I/bTE67Ewc2iDEA2PLUwFQFVWq5P/RDfSgLNYf1vMobK
	 6vKRs0qaBGjn54bNUqvLFTODhdMEKJdllGfGhYwnzuU972fXL8nIMJRi7A6d8AhdDy
	 vQUPj45sSXcrAYGkM33s7wC4oYXY5/Q3V4bGv97p5nX2olw+5JzdO/LBWFq01sFf4Q
	 IezfU8CbPqPfgxzucXayw7Rc5gkoRnH1cEfJOT09JtqD4FKsayzq0izm5bN+XidF7c
	 pjTzyfDgfdMQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.6.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sat,  9 May 2026 08:46:49 -0400
Message-ID: <20260509122858.eaf18d60002c.re-kvm-x86-shadow-paging-uaf-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505070057.198705-1-pbonzini@redhat.com>
References: <20260505070057.198705-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Queued for 6.6.y, thanks.

--
Sasha
