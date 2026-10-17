Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD129B795;
	Sat, 17 Oct 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254833; cv=none; b=OBR6DkKBV6+XANeaXO27OX8O0dFqtvn37iPvo0axNV+74R9JAB7d4PmUZJkDeRdv81NT6O1/NQ5n1b5SWLp3CjOQcydnTh7uTmyHimDUAXXtaJtuOWP6v2a8hErMpv58+1sa/wFDUNwv/FFjy/ktUJBqV6YBVrGN0dUGkoFDdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254833; c=relaxed/simple;
	bh=sZeGf+R3HeRq59y1/BharSvWIXj9JOKxyx4UFV7wfKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8vk6j2S8oAop552af5SrcJPux9+qQH1KxeGKH9biuHmu855Dfxun7PfauBMx0F8sme1bJ0awbEqS969vNJvHhcCDsjDaONd9KMTMr6RU2eigOZScwYj8OWYGD8Ul1849spWK4LeX0RAvIcdk9svc6zi8DQ8PjFb5LeRu4ZrDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=H6LVDirh; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="H6LVDirh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sZeGf+R3HeRq59y1/BharSvWIXj9JOKxyx4UFV7wfKg=; b=H6LVDirhcT9IaPoEDw2sCQCQ1i
	WM/qehuwBszVO5RhPtJ7AHT6ks2/VjAjy3Q585xJUbN0bU5bpvlGGFqUsDQ1Ve87C5e1Ou6PNML4/
	qZZ5+U4sm9qYrAAm/63oe+zDFkncT4Ytm5y78ba226EWKN+CsNqEz91LgMQ+aQee2iop+Xyc9oshH
	+BiMz4d68Yp/83Q9DicxNWEWjNUGa+g6FfpYx/6s26ROpKZGnrkYsy2TNV2vSA5NXEgpXGcoFcZmZ
	P5sF5pHMPuxT0qUELVPOpb8qFfi13WIaWwHEHgIIFeI+AAt+8ucOx5x4MdYm75Hv7WYNrG9vxie/L
	SqM4zCfw==;
Received: from mailer.gwdg.de ([134.76.10.26]:56399)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI7Lw-00BG0M-2Y;
	Sat, 17 Oct 2026 18:33:48 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI7Lw-0009zy-1B;
	Sat, 17 Oct 2026 18:33:48 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 18:33:47 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pbonzini@redhat.com>, <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] KVM: VMX: Load the EOI-exit bitmap into vmcs01, not the active VMCS
Date: Sat, 17 Oct 2026 18:33:40 +0200
Message-ID: <20261017163340.3968-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261017093016.32348-2-amirmohammad.eftekhar@cispa.de>
References: <20261017093016.32348-2-amirmohammad.eftekhar@cispa.de>
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

Thanks, and agreed on all of it.

You're right that it isn't reachable in normal operation. The deferral
(load_eoi_exitmap_pending) is what kept it off the L2 path, and ripping that
out reads cleaner than adding the guard alone, so your version is the better
fix. My changelog was wrong about the trigger and about vmx_sync_pir_to_irr();
sorry for the noise there.

Thanks for the Reported-by. Would you like me to test your version (nested VID
with APICv active, deferral removed) before it goes in?

Thanks,
Amirmohammad
