Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E833D9533
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279262; cv=none; b=iH1pfPpPMv1JFxb1ktyAJDuprp+1luihTzBk2/rcdGSAfil6Gije4CwouloB/U6QzvHkejgGs8IOPs+0nbLFDkierPD1bGgKnVnlMFK2zahnjF9Pn3oLOPvbd5/kM8ENFrZKRp5lalfQNMRqRKYsVAUeZYR0RlyKf5YxCuRoOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279262; c=relaxed/simple;
	bh=+V8uFO8KjUBEZ10FiDGjD6LAJ9EH5zGBb8kX+VfCtOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mg09Hyuw8Pm3izvVV8fplQ4s0uUWMSc+PqaFY4Q5hhC01s86ASMfvNyqxoQXck3rr4g2+WEkKkfeJDDFDgl82se3jcVgOg8aDEJzZkP3rBUT/Ei1InDukfTj34HdpeBqmyM94o4O2pZm++++WrFHgA0Vc7ZADCRGaKOx/ngT4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=LDNmFn+v; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="LDNmFn+v"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48af27fe287so307110f8f.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791279257; x=1791884057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jq4MvvelPJmLJTP64CCeQVSZLu/IREWVL/wvvlYXR5M=;
        b=LDNmFn+vPCgLAHGVEJ5RFSZOerw0K5YsVdDhGYeEEMnDdVbUHEoWvjiDevsA9m+kXY
         2Smgk0XLv2lLOEgn//z8ypMN5f4k+uEPK+6+oABKIuQ7LaWN0k6zKb9id5PsupUxeBBF
         EVc5jri1vpOfSJFAXf0Zear4Y/8gKQFeFa6ZmCJoH6pS5waZGuFzE1jH13QLRHBxN/Gb
         UF9hMpSijvL/dxWTXTb/Zf98ztlelOVbOEozgZU7PxykEwHNxDduRrrxxNHxJd8sJqty
         THmnl5q1FzkLG71LxZJXFH+BodhXeDXynEo3sDJ1xyaqlnLBPPUyvxYHx3/9hH3+ofaD
         l53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279257; x=1791884057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jq4MvvelPJmLJTP64CCeQVSZLu/IREWVL/wvvlYXR5M=;
        b=MNYp/rrGbIUtFThgblF/eGJOf/tSdVaAndD3ilZDlhtbVl+mfSDpUKGaxHkYgo1pay
         FyN9qpKE9AlnOxh3Tj0Efw0isKnB7Pp8OPyOM8DNWZN/4Sx4XcHf3zvGkHHLhR4cEaw/
         vt+cFbZyhTwj4fklazF0ks4ogN5Lt5f72+1a62KTAiEIqqfsPKhyOyCszvd5NkmNjv2r
         CGKfIuyFRKNcCEYYEZI6dRxEAZQZjsAkhnWS/z8qyHWT8zNVwnS65NeWMNRj6eK03nwl
         nLv+EMHKm2e31dDmjXh3/hiGKrv/FHkOrZEE77PnQbTARTGSq34MMWamnys3iKW2xp2H
         Y1JQ==
X-Gm-Message-State: AFq9FYKsL0rQF7iYnGpsHMGDIUrBU1Nnhmoeby+13ZktEHPYNFbPSmzr
	YdtDO/XtKRl20Id1Wxwgvb11mH0wA+tDAsq+zsqJeyr4ihuU/9F2fypoAKi/ZKLhQKM=
X-Gm-Gg: AYBFou3DneIlKq5WJ8ALmWMTvOxURCqGvltKtdAnl6ufYkiVCVlkdgx69VArv6qni14
	fQoa3zWLIXpyVPuMMH6idCiIb0l8wYs3qvU540d6Iqwp5jqzibEDuXEIvywSSQZtc/qaPst6qLk
	BBzX76PWYVjs4smVBa29GjWsG0UTzdrerWTA4SjNc1b5LKqf8GGfsIr6eiqk0/JtFHsuFVIr4Hq
	8SZ8NDr2X2SE6t/4U0oZ9YacuZayPtgbyljEbJ3k4/q36hA9cw1uB2Npj48X2TWqtQUJzKjW+P9
	yLNpydY7UzFddBMLQhcF/iFM8XqvutqdL6GAN0pbUIRDd6lXwFtXxO3VZMbWvMNFJOH02+U5y7M
	pSiRprqTY002WzTLI6tvYVSCZaGuIpMZW8JAYzPkUBu37nk/xN00hvKYC0KwhyiLIslN1QFmhh1
	3IQOmrqo+X1eQP3xWwRshi/EX+VkvSfM9bOZiMfDlX+wzv5wVPCsaX3pdY/gdUH4OfqskvCIr5h
	tZAeXeZew==
X-Received: by 2002:a05:6000:2210:b0:487:27f9:82c with SMTP id ffacd0b85a97d-48c6d19ba25mr1256715f8f.33.1791279256305;
        Tue, 06 Oct 2026 02:34:16 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:9c5b:8aff:fed1:19b4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c622b4685sm8853347f8f.41.2026.10.06.02.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 02:34:15 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Cc: kvm@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	Bruno Produit <bruno.produit@trailofbits.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: x86: Cancel PIT timer on failed creation
Date: Tue,  6 Oct 2026 11:33:54 +0200
Message-ID: <20261006093354.590415-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cancel the PIT hrtimer if PIT creation fails after registering the PIO
device.  This matches normal teardown and ensures the timer no longer
uses the PIT before its memory is freed.

KVM registers the PIT's PIO device before registering the optional dummy
speaker device.  If speaker registration fails, a vCPU can have already
programmed channel 0 and armed pit_state.timer through the published PIT
device.  When I/O bus registration became fallible, its cleanup did not
cancel the timer before freeing the PIT.

Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
Sean's proposal, feel free to change the FROM upstream
see https://lore.kernel.org/all/ar_PNEIvsQMQPMLg@google.com/
 
 arch/x86/kvm/i8254.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddd..33d772c7160b 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -790,6 +790,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 
 fail_register_speaker:
 	kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS, &pit->dev);
+	hrtimer_cancel(&pit->pit_state.timer);
 fail_register_pit:
 	mutex_unlock(&kvm->slots_lock);
 	kvm_pit_set_reinject(pit, false);
-- 
2.53.0
