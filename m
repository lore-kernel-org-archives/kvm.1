Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830443822B7;
	Sat, 17 Oct 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254853; cv=none; b=CLDmkazJtxLKk+F9LjfN9HOgAK036Gqqp0qO+CTPuDDPl8g3EMCjTekA+1nxxS4zcpMeh85KUouR/U7Ei/idJ/ylrziRB7YjjBdEtSOSLU1ogUk7sTXCDSrlJ9PaoZtxy5KD4JmJBPoBVxPwt46FX2Ly2bQjNdNu6qO3UFpflzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254853; c=relaxed/simple;
	bh=6/YLRID0R9aFb2/IJihCvuuk5bQsw5MQ6wWXavWn2hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFHGyIzi1JCWGInVVvGnwaM0Y7FRhPe3zJXquFCZiRJHOVyrFvcn8cl6a3Nx/C3qwntxrrvHR636JXjIgW32elpm08nPmTZC+q++/5/+f7jMRfh3AmroKi2i86iqvzugiKwma/HCoNws58oBL+e+M5HEm7bT3m+ad8WA4tg+n2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=MiC8gNey; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="MiC8gNey"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6/YLRID0R9aFb2/IJihCvuuk5bQsw5MQ6wWXavWn2hE=; b=MiC8gNeyW+OdlodOBDPNz3h/Zd
	IdVm64WWuUCE9xwEsDi1mpMSmEzKS5cKxyjJaayW02MaDUpWjO7M3iGDZrc8HGwSke56mlZbahhvA
	9Fy7RxOxhuEr4WhkQazz+vnidjrO6aA6ur3VaU868XOtZW6PYHTxJRH68JhPWqOIZ9UTtMCWyowfG
	W4A57k+mpB/mpXNgXpKeYFXDxVbPuryRZzYFSGJJqs2Kd2c3qnZbzFSJrcIxWsJMyx4Li9m1Od9hu
	RK2XjuwKwA/d4jnHuJkfrZvgK+czUmfH/sf8lfxOc8v3zaBkK8/cZyZ7Y2Hnuq1U47ZQZg1cD6Kvg
	fk5/nQrQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:57029)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI7MI-00BG0c-0n;
	Sat, 17 Oct 2026 18:34:09 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI7MH-000A6C-2f;
	Sat, 17 Oct 2026 18:34:09 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 18:34:08 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>
CC: <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <josef@toxicpanda.com>, <mason@kernel.org>
Subject: Re: [PATCH] KVM: x86: Ratelimit guest-triggerable IOAPIC/LAPIC log messages
Date: Sat, 17 Oct 2026 18:34:01 +0200
Message-ID: <20261017163401.4045-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261017093016.32348-4-amirmohammad.eftekhar@cispa.de>
References: <20261017093016.32348-4-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-08.um.gwdg.de (10.108.142.67) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Thanks, both. No objection to consolidating; Josef and Chris's versions cover
more sites and carry the Fixes: tags, so those should lead.

For the two hunks that overlap mine (the IOAPIC wrong-length and
unsupported-size warnings), a Co-developed-by or Reported-by would be
appreciated, since I found and sent those independently. Whatever's cleanest
for the combined series works.

Thanks,
Amirmohammad
