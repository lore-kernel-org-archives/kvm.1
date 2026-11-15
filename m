Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760662;
	b=hdbzfHEq3mQaMKYBjHQ3d32MuqhbwcJLXEym5qcge0Lvp1asAjxYuuhbIgZZwhudwO1Z
	 jk0c96AiDchvK9cBuUQx4LGK1Tr68K6qPmo9Rlx9wcKtBY9DD9gn0O5b/TP7uSrfp6xIb
	 b4w8N9iXzreTaJdgI9hDddX3yCyR/RF7zhgbe870Ry+JsZiHvrhbJYJW+3opfh7wuIai0
	 Bj15tF88G7ecTxLMS8cJZtLPB3cqSVWawj7ixKWMo4eYnA4LwSFAIxDHgjnhHFvuwLlhq
	 QTk7nJawLAM2Jin1MQoVxawv+ZFcl46zF3WZelYUYtZOburXFhrMaRRUctX4bjbfmgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K+gvpLnHAWCS2qej9/dKDbqHpvb2Unj69ztz/dYZD4I=;
	b=J5CgNO0yBgjwHV0+p4ThfVfPAQwaslD0IiFUzvpWlD1/yV1nglbbD3ApjG0TS+cDuePE
	 SXUpz9eVgR6iFhfHbF89i+AleSH48Mdf9piXv1/UO0sOr8fW7+OObcEd0SOmuLUeqC/6R
	 QRtL1pRTX4YAwR3JvXpJqu1fQFp2prpOacXjVMyIS4JIl7nxG+bwf3gdgNdYA5OBcWiFs
	 i1eB8P3UVO0G++VihVdaeShy2YNIIVADbotkwUS+EXWoEhZKstNZQFivcOT9g+M7V0kxn
	 xwdTINk/8H2KzFOLj73Dmu1x3ffUD3w/pj2eTZM1tPMVf24OXdbx4kyJkLi1kSmP/bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TAVMfL/F";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DC606A31E
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 16:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D97DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAVMfL/F
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so7914669eec.0
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 08:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760661; x=1795365461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+gvpLnHAWCS2qej9/dKDbqHpvb2Unj69ztz/dYZD4I=;
        b=TAVMfL/FjyLswmQ1OblEHRo8HslRF3gicwrmde1Gm215hLqGigb1ZoLJ8PZV/CS4Gb
         ilniSrB7HYZYBWzDpptKEH8rbtveWPXCIzkrlVwtCwDTl+kdC8t50LXkxKBy+akDCell
         tjmcSNXsP7AGvI7U1ZN+NhVuycyA2TfbKsOJR/mjZdkVGHJ2UiQtKk/2F+4A0dPZXN+b
         VIDphpsSG92z7rSMlzU6wn0Cwy9JQlbouj2kon93XxBEWDWjTXuEbSaLnsA0XtXKl7Wn
         PvrwlbJUfWbnaWo5nUd5b4yLb4Fl8UsHBX9FIhPz15QW8R4osAe8KJJCn8+7Rhg4J2oQ
         /DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760661; x=1795365461;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K+gvpLnHAWCS2qej9/dKDbqHpvb2Unj69ztz/dYZD4I=;
        b=vNKHdcYyZH4h05BGKWNsOCCJpuObObmSGhqrte4M475jkmTMcn9lNG5QRHfbhf6Mwt
         pd2hxMn2PgHXjUnzKP9BzqNCr+px2OHE8MLnjaYD20UJPSdNQ7dAxu3SlBkuLNB5FQtN
         FO3jpPobTZSRzvVeyU/k5nzMhk3pT77HPM3ZnowhsuK2RvUWfknqhz/j4124BnBIur3I
         RZYVNL4LGzg69DqW0cX9yHE96kBHT+E0zhQxs2o4b5kimnDQmdZh1lGt1bGxg79uchrs
         ux+5Ikt40JYq1BqmMt1wmgB/GhAsdAy5ZKJnQkNQ6S8WImO8Xy2+vUWJZHOU8vR8Omh2
         kCqw==
X-Gm-Message-State: APuU4Z9mO8sr92YVIf4Bhj7hBFzYuOIYDnlzaFEjVQJwNISHe/8E6lZq
	CN9EjU+fJTIsjJ8ha0PEkZ4fykcB6VsdKeatqMxD5xpnbsvbEZpk3z4M
X-Gm-Gg: AYBFou3bwincj1QcyhzpO+6eHJx8+g6LsEMYxt9pl3cQ/uL7xN4nQFSn+ik7IE+Pp2R
	uvM8TleHM31UFhHD2BMmsrEtP1qT/jfUwEIhPkEe3WEgPo2SzGB7etBQdKwVkKGYjR8c+FeHma9
	b6sOvqmXJYpiADcPcp4NJVLvgWuj5bTnJyOVA/YZRO6ES1/URcC7jiwTPfts7Wd5eglOX017N0i
	hQ0vA+9QTRPDbRBFtlvrNgwOHZpplb/byj0vPyOVrNMlbKE156RQPoL3Zc2aoS5CpV2mqYx3fnY
	0i8Xzr68zRlzC7nIqea2DZwVxLolTAoG0Doe196Zae5IWzrOZMkU7HmRGzJiRa7cbBLAIf1xgvF
	spo8O8K0WcDXJs4iS8SboPGoCOF1x87lnEN+We4ivWLhqrDWyOPO29ZAPZ9N8I/WFg3pOHvxzOh
	u/wTX74/shcuBKaQVpMhS42nu+EeossX4x79JIpS35jxLR8rKcImpjGNfrHpI2nQSUk5/0mxIZB
	Ye3MrldQFqkxpE9ipx2zZPbDN5eSrNzhLNC1cCT2Dp5PKRQCp6EymK+TBCb+O74wB4qmDl2Q8M/
	fftjUNoSAdDe2jUT27k0/9cV4RU0nuFT6iSjTrbofLzff9X2Vje3lOgCtODZIKYmxQtO
X-Received: by 2002:a05:7022:3a87:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1b503068f8cmr8823437c88.1.1794760661026;
        Sun, 15 Nov 2026 08:37:41 -0800 (PST)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm28775558eec.23.2026.11.15.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:37:40 -0800 (PST)
From: Cheng Yongkang <teel4res@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KVM: x86: INIT leaves a stale RTC pending EOI
Date: Sun, 15 Nov 2026 08:37:33 -0800
Message-Id: <20261115163733.227072-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sean, Paolo,

I hit a corner case in the in-kernel IOAPIC RTC EOI tracking. It needs
a vCPU to get INIT before it EOIs an RTC interrupt, APICv to be
inactive, and a VMM that injects GSI 8 with KVM_IRQ_LINE_STATUS, so it
may be rare in practice.

When a vCPU accepts the RTC interrupt, ioapic->rtc_status records it
in map and pending_eoi. If that vCPU then processes INIT,
kvm_lapic_reset() clears IRR and ISR but does not touch rtc_status.
The guest can no longer EOI that vector, so pending_eoi stays above 0
and rtc_irq_check_coalesced() treats every later GSI 8 injection as
coalesced. Only KVM_SET_LAPIC or KVM_SET_IRQCHIP clear it, through
kvm_rtc_eoi_tracking_restore_*(). The lazy repair in
ioapic_lazy_update_eoi() only runs with APICv active, so nothing
repairs the stale entry when APICv is inactive.

On v7.3 with kvm-amd.avic=N, running nested (the KVM under test is
inside a QEMU guest), with IOAPIC pin 8 edge-triggered, vector 0x50,
physical dest 0, and GSI 8 routed only to the IOAPIC, 6 out of 6 runs
gave:

  KVM_IRQ_LINE_STATUS(GSI 8)              -> status 1
      LAPIC: SVR=0x1ff, IRR[0x50]=1, ISR[0x50]=0
  INIT through KVM_SIGNAL_MSI, processed by KVM_RUN
      LAPIC: SVR=0xff, IRR[0x50]=0, ISR[0x50]=0
  guest re-enables the LAPIC: a stub in 32-bit protected mode
  (set with KVM_SET_SREGS/KVM_SET_REGS) writes SVR=0x1ff through the
  APIC MMIO page and exits with "out"
      LAPIC: SVR=0x1ff, IRR[0x50]=0, ISR[0x50]=0
  deassert, KVM_IRQ_LINE_STATUS(GSI 8)    -> status 0 (coalesced)
  control: KVM_SET_LAPIC with the same LAPIC state, so
  kvm_rtc_eoi_tracking_restore_one() drops the stale entry
  deassert, KVM_IRQ_LINE_STATUS(GSI 8)    -> status 1

The entry is edge-triggered, so remote_irr is not involved, and GSI 8
goes only to the IOAPIC, so the status does not come from the PIC. In
the 0 and the 1 case the LAPIC is enabled and its IRR is empty; the
only difference is the stale rtc_status entry.

The code is unchanged in next-20261113. Xiang Zheng's "KVM: x86: Fix
stale RTC pending-EOI tracking under AVIC" only changes
ioapic_lazy_update_eoi(), so it does not cover the APICv-inactive
case.

One option is to call kvm_rtc_eoi_tracking_restore_one() from the INIT
path of kvm_lapic_reset(), as kvm_apic_set_state() already does. I
have not tested that.

Thanks,
Cheng Yongkang
