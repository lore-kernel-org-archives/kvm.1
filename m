Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890485;
	b=f5LdA68DlCoRc+Zzn2tH2/ATGYxM+pk2ETx6QrR2F78A5a6/wcOUkUuI4KqtMoowbMBZ
	 J0uZrmCAQx39qy1LefyoLXy8xujHM37BAxQ8hxNPZrWVD4GhUiCNEagU7I+rOVNWuXa9+
	 Se50qSnnAPyU2n/423RzyW4G5LjPQyUOIVscqxvpbC4LKlNaAyPdijJMABLl0edH7D203
	 lyX/OLrfW6V71vx2l/P9F387HcPqFBwTaw9YwsqatyVB1GfJna6E5BTc6yv8crgveriY1
	 Q4SPnapNL63ul7Itx/FIDFk7h33hg3zXYZIbu+a4py8NUU1+rNtUC7f51mv8FRLbcEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=O0tTV/LxO1caisWems9pMF6bXByXS9sZ02w4o7mP319dwQ84rb0t5rUZCwoGDMj4G9IG
	 KqMpSSCBjM3hnmq2vCdRLjX4bxR0Pf+sMTAFVa5vXjAVVKsd8nMKW6IdYlfYpWgT9+dNH
	 DtoVe+QzbfSsOpgawt1wbGAXyrsLzRFsQROkuriGUBqMd1+vX2EJ4/NhxsUvS58gGg4aR
	 O2oJ2m1Dp1HUh6jXwZyeT6Fw1EDEgwZhXG21S0Hqox7qiW+17xWs4fAsegN7t/uiIzGTx
	 ixQpU2seEfskFyq4nrGUuxtFJFJI1ze3MRU3r2V/HTVrsB+Mt8FXbQpctWzayJugt5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ka/n6n6S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35162606A31B;
	Thu,  5 Nov 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ka/n6n6S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F71F000C1;
	Thu,  5 Nov 2026 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890484;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ka/n6n6SUkO8FUJIgBHv48WOD0oWPcUaYm3OIfHydr7leKmNS1cXXgvy1BCOmzY7X
	 A3tB+MYRX0nV0bvMd9epbeGw29jOY5BfHmOvmuwk53qPWemsE8+QLe5pAsppxy+tJ+
	 pS6oQFHfyw+dqwZPQ7CwhZIG3iTw9gkPW64piez2I5m1kEFYSPdNh/00Mlta5eHjfk
	 N+k0wMhBnIpt18dpkqTZqQlugv7lrmSAEsUbVGnnQi/9V8ZlrKfg6xu57tXmQl41P2
	 3fjLNCfvtHW+rtdKu280/u2x+b/xQpxJybzMK6S++k/+fV1ce5qz5yeN8bC49FKhNp
	 zxd1TCPEqj9aQ==
From: netdev-bot+sinfo@kernel.org
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mtosatti@redhat.com, pbonzini@redhat.com, cjubran@nvidia.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] ptp: kvm: report paired cycles for the active clocksource
Date: Thu, 05 Nov 2026 14:54:43 +0000
Message-ID: <179389048363.488859.14886385431417257658@kernel.org>
In-Reply-To: <20261105144821.5299-1-wwasko@nvidia.com>
References: <20261105144821.5299-1-wwasko@nvidia.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
