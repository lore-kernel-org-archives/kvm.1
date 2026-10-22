Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705936;
	b=Z0sofT9CZtSZuTU5HGfEdQBR5T/uGCdznMhcCahDdy7BpolYndMjgHzgEtWgZ/vTK314
	 LfYeVKy57iwAw3mPaZ818lAc8LovOSdmHYrFCHsLSaUa9nDl0C0ZOfis94YUItwEHwB35
	 rEMWGphYlVMR0z7K8dQm6LjibOPIuI+JmHvLSqvVPXgI+0fmT1CCMbt9Wdi9NhWxYNyn/
	 pTw5LoGls2ZciNsmhrlNhEuoBamLwocuZOrpZvfXY6tUt6rIlFHfSnT19C/cf23ub78hC
	 3BBd9oS38DQ1RIyGuVE/ATdQK0N2dmcAnhacp/fLdLIMH9yyrbtCl4/vHTDbnbuVpZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705936;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=3W+6Ice8osJJBfjHM3H8a0MYmw1mb/p3pZ0FWxhYxqU=;
	b=QSlrpWroh1eie8vTVqpDmSVMlPEVLwvVAN8qxsUYin3hVUpb0sQPrv4Es6fhRTZIMvvS
	 xi7pIa2tqfRyJzqqV4NTem8+EIbLUzXxx6gR+MSwDqVeUj1a5Gh6+kaZm3jEs/+XCZZXN
	 UMZaMLQfeKBkd6LWU3snv5qVkZVlXGCPA4kPTLl+RWh/qE8+zeDtSazUtYzCALeA7FtfF
	 Y/hLrEtkziPyM2G1FlJU6igbmOynCOPJLXgBDh+YBtfWis6rxqetZSbWz4BxteagAjtJK
	 qHAt+es5OENQABWIzrzYxeJGDupzSv5ani42RcZ+mmuSkFA2KmQ/vYtwjiNWgXpCPeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=ZijyUnZm;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C7606A31B;
	Thu, 22 Oct 2026 21:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C3C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=ZijyUnZm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3W+6Ice8osJJBfjHM3H8a0MYmw1mb/p3pZ0FWxhYxqU=; b=ZijyUnZmZdemKu165S0/PS2flb
	YJM4IKUHxLvyS6X2w977hqDzgI/WCrc0dJhuMCGfwwUYQFFEjWYZm8usEmmsAt41bpbXWNC38Isxv
	6JKYeOcjSL5//08Uo3iSkVMMjePt2irn0/Spibmk09iE2IQgVgeib7x0z/fTopQD+XDSmmmmb49HY
	se+3pDGONYcO9OWwHzaSU4P8ZNmpZWGgocFA8QKXaiBOf4BLuKQ+QEVrnBQVUBUOiOJzgrAA5MQzN
	EZwV0nHkKDjs47MVAlCM4YN5wbDQds0FFznaZQDI8ySK7OXdHEkUHSZHUUals5hlxRH3qxRYjbqvB
	6igS3Kjw==;
Received: from mailer.gwdg.de ([134.76.10.26]:40152)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0hp-00EBqT-1E;
	Thu, 22 Oct 2026 23:52:13 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0hm-0001o0-2q;
	Thu, 22 Oct 2026 23:52:10 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 22 Oct
 2026 23:52:10 +0200
From: <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammadeftekhar@gmail.com>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH v3 0/2] KVM: nVMX: Add the activity-state cross-checks VM-entry requires
Date: Thu, 22 Oct 2026 23:51:44 +0200
Message-ID: <20261022215146.233479-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <atqDVkHjdJ2iF9Uv@google.com>
References: <atqDVkHjdJ2iF9Uv@google.com>
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
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-04.um.gwdg.de (10.108.142.63) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

nested_check_guest_non_reg_state() only verifies that guest_activity_state is
one of ACTIVE/HLT/WAIT_SIPI; it performs none of the activity-state cross-checks
that VM entry requires.  Per Intel's SDM, "Checks on Guest Non-Register State":
the activity state must indicate the active state when the interruptibility-state
field blocks by STI or MOV SS, and when the valid bit of the VM-entry
interruption-information field is set the interruption "must not be one that
would normally be blocked" in the activity state -- for wait-for-SIPI, "No
interruptions are allowed".

KVM cannot rely on hardware to catch either miss: prepare_vmcs02() never writes
GUEST_ACTIVITY_STATE, so vmcs02 always carries the active state while the
injection is copied into vmcs02, and the physical VMLAUNCH sees a legal pair and
succeeds.  The missed-exit WARN in __nested_vmx_vmexit() cannot fire for this
class either, since the offending field is stripped before hardware sees vmcs02.

The two checks share this justification but are independent changes, so they are
split into separate patches per review feedback.

v3:
  - split into two patches, one per consistency check (Sean)
  - drop the comment that merely restated the code (Sean)
v2: clean resend of v1 (v1 was whitespace-damaged in transit by a mail client).

Amirmohammad Eftekhar (2):
  KVM: nVMX: Reject nested VM-entry in a non-active state blocked by
    STI/MOV-SS
  KVM: nVMX: Reject nested VM-entry in wait-for-SIPI with a pending
    event injection

 arch/x86/kvm/vmx/nested.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.34.1

