Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400325;
	b=3H5+kVdpO9sIe1Xw4g/n9H3EI9Kep+oVye6jFRr6WbJu3GhBEbZgEPqGsR02GR0cFIBl
	 uo60jDzmn76anDrAOyzn8ZivFXbHrcMmtrpNT0ceJXb4h865NB3gZXB0gEaoWveCSrdjw
	 5pCjCOnFK1Dty00+T1nsjjvZfZ6RHzaHvArK/476HD72RZuZqH+oX1pYxOKsXxfTpM75s
	 Lqi2XoN/Bm4qKJ2+/ZuH6q86usvUGjxFhYfynGVBx0wJusX05sUhDwhtIg1RJZUM8o73N
	 G5H6k2q7G+rdQhgqZUfQl0yIcf092TLhfrl6Pn055uLjvQAj18PC0A+kfVeyFafe9BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=o0MHwSxfM+LhmzSAnfcnmmd3bNvzyOl5ZnRTOhRywAc=;
	b=erQGTtDwX0itgNydBuqEjf56LxMEkoJlhRUJkFdGuN3gXL/9MyDXRWr3dOEbEdAEjdjc
	 n2uey2lE4HkVLb1EOLzGujlDZEzJtvxQUHaBhfZ6EVyxKsx2Bx/qKS0oy+R9cHmxk9/g1
	 Ay4D3pr76sF/CV/fRcOiyj4lOSbDNINe7Om0H1dz3rTJzYQZ0M6bOxtTjZbYUBYdL44o6
	 d1r/A56fdJgNo65cH5wLrrYb3xKlt+SRJ+eFetfP5p7xP/EOzYl8e8Qnf68IwBNoda2aE
	 HdXYAFuTgr6Whw2SdJ9/nm/5BxUAGaXyzfUWhqTGJg/oh8MZ1o1cDgqPevlM5XF1Jmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EbIDHXZp;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A83606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 12:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A83606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EbIDHXZp
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so1903412a91.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794400325; x=1795005125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0MHwSxfM+LhmzSAnfcnmmd3bNvzyOl5ZnRTOhRywAc=;
        b=EbIDHXZp58jvc6BTkJD7mAw5xMrg6AU2qc220eDZaH8KPknPi5GWjyyd3N9BDLAQwY
         n2uPmwPWGuIqm/gc50mqBsBp2Kglj7cVf3cdooU4YaoEkbvDMGlb6uZbw3a5UlWjqBbQ
         72ybq27YAMvqSVlK+OzaRdYApWYxD9MUapFYoY8ceQk8geAaJ3vgw0OVtR1g8IKoy+FZ
         lg7KtyELBTYQtiZnf72FgCgeVpyJ7YDhmweA4MDMjskCROi/xSGVsfHJokJv22isEemj
         WGrLkIC9FizICSitwHM2+jAOcaxzdQ+NTUHeEn0mDUPihHR7+ijsWety/DOFPGfQJHo1
         sHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400325; x=1795005125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0MHwSxfM+LhmzSAnfcnmmd3bNvzyOl5ZnRTOhRywAc=;
        b=tDB9O62yBHZmpqEBBUwnQ49HRMCqT0m8KpaIlVPI5ee/Ju2sNasUG21MoI+WK086Ao
         9QuS6TtWcDPvaVqNZ6s5cOlbCxBAauPriMC4trAHHV1zZqeG/5IGopkoFpHuGV5PHge0
         1NioosskmYqmsdvZGp0ybImp9IaM7KUSyiujSpOzQAzV4oryPMHMnAo1j9loeTJugGMs
         meyrhfRHFHlHAKd1NpjZ44iUheJTtCPSEIxp9K+IPMh01B4AMv3NHSuKTWKhwzOOGrbt
         gaQAdgsjhLk2aVkb8seS+o8FwrRwRcnvQAUm3QYk2Ly0I/ej/gQ8brqPnCCUqOSxr97I
         nCdA==
X-Gm-Message-State: APuU4Z+TxxGoScbPig3nVaBKATG/wC+PsF7kvmlMHlPEVdVEKcOq/9N6
	auCNFaOoYpgjs188s7U8ikb0cst6/G0Dfa9pbQ76nhqV0DA4dp3aGVcqNDsQiw==
X-Gm-Gg: AYBFou2kA6+wWz0kFvLnp6uh/3j99RSVLmpSJ3VNlfTwPB7hlRek2wla9wyI0JXTmQF
	YM7aa6LIq9b5h87ncSThMnZwp0yloBEoxH98DfFx4p2PSiAemW7v/5rQHoeOPDZWnoJ0zupusHq
	oKbrlCH6CB9gbDiZSPjJhw0h+uMLa7ofeun004QSOAnYOnGo4YhNZpipNHXw07mCpmFCFRoY+iN
	ZY8nBswzbCHCDInxtHoZ2jou4cH8CpG3kPUzSd9Yx17KysH8mlMcTn161VJYEyd35VFD9NFrhuz
	ipRSVYlAQ9TyHMNTwuCKVYAOgfJgDTitvEJLjwqTE1Jne3DuAqNcSHx+ceKCXwZbCjcRxSfWP2F
	i22E14V8pZ9vD/MEARN+W6gyiUBsMWzasQMvh7PEr6CQmblo1Z9Fy4134Z6QlaoiL1HuE1aA6vB
	GDUoBiMP9xjVP3Q6b1BoGT+wsI2RkQGYcgnwBoFYn3cdhKBmwRU8aMF+V9fsJtIHqLktmHUHEtU
	VoVCZiSqhj1RqUHEet1r5Eo27mpGaei9rkRuEVDQmN+tx8uhGqH/BjhHONLY2hxtTlUEC8iWNs7
	/Yupj77tqjRdNkA3QXvRIkiWpmikFYkk
X-Received: by 2002:a17:90b:37c3:b0:3b0:c11a:9026 with SMTP id 98e67ed59e1d1-3b18300a02emr2424293a91.55.1794400324493;
        Wed, 11 Nov 2026 04:32:04 -0800 (PST)
Received: from desktop ([14.154.190.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e1f88casm4231932a91.12.2026.11.11.04.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:32:04 -0800 (PST)
From: Dongli Si <dongli.si.linux@gmail.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com
Subject: [PATCH kvmtool] x86: mptable: Fix PCI device number in source bus IRQ
Date: Wed, 11 Nov 2026 20:31:33 +0800
Message-ID: <20261111123133.1228125-1-dongli.si.linux@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For PCI interrupts, bits 6:2 of srcbusirq identify the source device.
Use dev_hdr->dev_num to populate those bits.

Fixes: f83cd1611d4b ("kvm tools: irq: replace the x86 irq rbtree with the PCI device tree")
Signed-off-by: Dongli Si <dongli.si.linux@gmail.com>
---
 x86/mptable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/mptable.c b/x86/mptable.c
index f13cf0f..f4753bd 100644
--- a/x86/mptable.c
+++ b/x86/mptable.c
@@ -180,7 +180,7 @@ int mptable__init(struct kvm *kvm)
 		unsigned char srcbusirq;
 		struct pci_device_header *pci_hdr = dev_hdr->data;
 
-		srcbusirq = (pci_hdr->subsys_id << 2) | (pci_hdr->irq_pin - 1);
+		srcbusirq = (dev_hdr->dev_num << 2) | (pci_hdr->irq_pin - 1);
 		mpc_intsrc = last_addr;
 		mptable_add_irq_src(mpc_intsrc, pcibusid, srcbusirq, ioapicid, pci_hdr->irq_line);
 
-- 
2.56.0

