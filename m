Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446237BE64;
	Sat, 17 Oct 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254844; cv=none; b=J4uNsFDV5yvgP6p7Jl1ve7Am1vNSc7I1tOFIdXuj8e5eDh7dTENDKRgi4evA9dN8dLAcc/O7iXolZhTouTsdcJOxEVbbZi6Jxm7G8bvPnJly6/C8fWMkf6oaHUvbTLdkndrbfCjRJPiya8TnWANm9X/Jq0yYC0Nd1cr+2zYC9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254844; c=relaxed/simple;
	bh=QKRX68dT420xpZLJ6RDvKkl8rSESTg/JD3lEVVMDOjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fswGr87JbWBivsHNEdivEeGBEOpYn4gtvpnL/zg3uJhmKKlwTASAZgAwTv6syOSD3H48yzTYCZ47eW61pRbtJlQ6yGBzH3nWBVqyLURZ6lZjbCzBiJwtVeap4ek5mrFr5HqwqAY8vtPnvV7JEmbOgjslUCXyKzDuVNMBBtQvWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=AYLnAYjC; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="AYLnAYjC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QKRX68dT420xpZLJ6RDvKkl8rSESTg/JD3lEVVMDOjQ=; b=AYLnAYjC0sSe9D9F+d+alI/yEX
	O6Iqhfva4+LRnXsNkFzJQiJI3ASSQp7GshMKJ1Nxcg+/qcNE/aA5hFzTd5g0OvLQo5TxuUROxSmKf
	Ani0Fzzmqiyp26QpgtVgJEiV8ltxkNNCPV3GHKLebyCMU7aAOnhLMBMh/5Z5LKKa56lcqePPHfTDR
	15lsS3Ew0UajImm73du6omtjLalBoQqKe29+e7ddpvJJNpQCQRW1e4rUeyxruRzJdvlWenP+QuhaI
	mDTTto/UHn5Gqv+q8Y9ttlYf/q8njiRdcO09Gb+c2Lq5T89uynwS1141u41ohSLGf7nygHqR8HxLN
	/6K6Qi1g==;
Received: from mailer.gwdg.de ([134.76.10.26]:57281)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI7M9-00BG0S-01;
	Sat, 17 Oct 2026 18:34:00 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI7M8-000A3W-1w;
	Sat, 17 Oct 2026 18:34:00 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 18:34:00 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>
CC: <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [BUG] KVM: x86: Hyper-V VP-assist page reuses the KVM PV-EOI gfn_to_hva_cache, so enabling both WARNs and fails KVM_RUN
Date: Sat, 17 Oct 2026 18:33:52 +0200
Message-ID: <20261017163352.4006-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261017093016.32348-7-amirmohammad.eftekhar@cispa.de>
References: <20261017093016.32348-7-amirmohammad.eftekhar@cispa.de>
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

Agreed, the stopgap looks right. Gating kvm_hv_get_assist_page() on
vcpu->arch.pv_eoi.data.len >= sizeof(struct hv_vp_assist_page) avoids the WARN
cleanly: when the shared cache is set up for PV EOI's single byte, the
VP-assist read is treated as inaccessible, with no need to untangle the shared
pv_eoi.data storage. And I agree making both features work at different GPAs
isn't worth chasing.

Would you like me to send this as a formal patch, with your Suggested-by,
tested against the reproducer (both features enabled at different GPAs,
confirming the WARN is gone and a well-formed VP-assist still reads back)?

Thanks,
Amirmohammad
