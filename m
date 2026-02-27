Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A12BD5A7;
	Fri, 27 Feb 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205206; cv=none; b=DGljaH8gV4bsZj0UTr4PPE5Gn8B+uexmM6pk2v9SCN6rPFZYxamBKPe28hITzKujXslzMoj3T1gJEb0R/VzCXd7Tr84qMKNwfzx7SBEzJvVnS2hH0XD9iY8MyPjXMIMp2zxGyy5+eroE8SQ14cZ4SGAoFkv06/D0di/WFfT+ZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205206; c=relaxed/simple;
	bh=U/AYMtm3HcMBARqjsqpovNKCJYz+YkgFM5S2Dw1nT34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYUKUyF2zxLRjEtvTfrokw4zARXWT5/EtNjTMmVbfyy1Xbx3y+NUBsKR1TJ11hrJnL15PTWfV/IIVSsnqf4ACQWLRqcf0UDbpXghccqyagExHFqkDiSa9XKmpkItm/MbDFzx/MI+96kt+1OPQiwwJ3ErqLrOVCxe+aR1mAM4OmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=VBFZUizv; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="VBFZUizv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FWU+AoGX9eH3mCsh3LQUgdVuyGEg7A83/ykl1w+gkCQ=; b=VBFZUizvgZG78Youf4F+MeuRT2
	zri9gJa8VJVZ5M6To8Tru9dkJszT42T+HnSu3Linjj54Cre1zTBIRISI2Y2bBBZzcBR/QsOFFXhxq
	ta5/gvMUNi5XaBlqWdwXys81LGEl8Oq15xR6bbzo73PtB/vmOYhPpEzvtDSHj3E/dCyCXg4Uxjop+
	EBWg04SLhWki8tp+QNbFBzkK7dcpZKPpKVvBo0Oqhd5LaipYyIaq5LE0HzdnTqy17Hd1BQ9M9+lVd
	MMJ7Y72wIevZWLffmLfqJs7PD9o/ZNjE4Ebo4POqVfrCG9pLNOS0pQGM5R8OtCzT8ulNWsHGzN35Y
	jsDMgJfQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:56296)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vvzWi-006hGu-0F;
	Fri, 27 Feb 2026 16:13:12 +0100
Received: from mbx19-sub-05.um.gwdg.de ([10.108.142.70] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vvzWi-000PaN-2i;
	Fri, 27 Feb 2026 16:13:12 +0100
Received: from localhost.localdomain (10.250.9.200) by MBX19-SUB-05.um.gwdg.de
 (10.108.142.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Fri, 27 Feb
 2026 16:13:10 +0100
From: Lukas Gerlach <lukas.gerlach@cispa.de>
To: <radim.krcmar@oss.qualcomm.com>
CC: <ajones@ventanamicro.com>, <alex@ghiti.fr>, <anup@brainfault.org>,
	<aou@eecs.berkeley.edu>, <atish.patra@linux.dev>, <daniel.weber@cispa.de>,
	<jo.vanbulck@kuleuven.be>, <kvm-riscv@lists.infradead.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <lukas.gerlach@cispa.de>,
	<marton.bognar@kuleuven.be>, <michael.schwarz@cispa.de>,
	<palmer@dabbelt.com>, <pjw@kernel.org>
Subject: Re: [PATCH 4/4] KVM: riscv: Fix Spectre-v1 in PMU counter access
Date: Fri, 27 Feb 2026 16:12:47 +0100
Message-ID: <20260227151247.18602-1-lukas.gerlach@cispa.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <DGPS39X0VRTU.3ATPEH33LUF1G@oss.qualcomm.com>
References: <DGPS39X0VRTU.3ATPEH33LUF1G@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-06.um.gwdg.de (10.108.142.65) To
 MBX19-SUB-05.um.gwdg.de (10.108.142.70)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Thanks for the review!

> This one also covers a non-speculation bug, since the previous condition
> used cidx > RISCV_KVM_MAX_COUNTER. :)  I'll send a patch for that.

Nice catch, thanks for sending the fix.

> I noticed a few other places where mis-speculation is possible,
> see below; can you explain why they don't need protection?

They do, I missed those. Will send a v2 incorporating all four sites.

Thanks,
Lukas
