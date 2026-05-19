Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776F279792
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151468; cv=none; b=fXrP7OH0KSethJRsOPYHyy/06kv7OKGBbt5yLrFJUoTpyd9FHlTwcob2d9ZG3b5kOqMfa83bMl5bqtcDQDhEtFAfjW5t5oLJ/WBnqfq51eKrjW+CrkHY5dvuk2K19V1cGtNOMKkqKPRFaq51QqRKXUhsTHt49asKMrjUezIZGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151468; c=relaxed/simple;
	bh=mf+b12dlucQUnlSWOx30yrfvDl3YQgDU68GLYy3/jrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jUcYommZIY8hbgVDwCFK8Q07Y2SbtOO4TPGp6q8DYEtUYelwZ4YPLneqFhEBSZsO5d6+c8i62X7KdTRKKLVsSFy/NeDmdQ7HmtUth97vZELN6h0t40ds9Ltt2mHpCX80yJ0iPuBp04j+h3+qMmlto2PNbgKQBnH5qlLuMYs1zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hgBYtlvN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgBYtlvN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c823549b1fcso5480863a12.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151457; x=1779756257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKpdVMI5zpzIt0RT5UGmjVvs/7f75J168+G6ijPHYws=;
        b=hgBYtlvNaDBOWjR0cYrGaO6RdgNsdx5ZhNd9cHxdLWA4uv6BxA9nc+fowVl2beNEpx
         Qa2TXUi9oeR4bf4ud8QtH4F5wzqjkcXenTN0r4lRSLcpShGdQoRaQiDvyPQSvXnCus5h
         nnLlveWBkl1W0A+xyn77DrJBfvtpwD+DwP4YNAWeqJ7DktWfovKo99gkBxaM+2W5mKzR
         JyC9j0nzrcJkOin1/4fnGHY2fTimmPbpHZxku2bC9KLue50LKBMc32G8miRIoModd/cx
         Llgum0DUZx3edgBnzQRpuBch3P9oHvuN1RtAbTxS32NbZjODzC5TkRjdEX6rXsibqzEE
         KSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151457; x=1779756257;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKpdVMI5zpzIt0RT5UGmjVvs/7f75J168+G6ijPHYws=;
        b=RVOOhHhziZhUv/aD6p36xCoZRCS0imEd9+O8Yc/fUsPCE42tmYJ7D9jhMPL5+DW1hf
         g29CCleJtfc58pkZlAM6U3hU+SG61OFABBilL3v/oHuC1jz4PoOJDtps0WzYEyM/kz2Q
         BWlLQb9EX/iovARut61PzsvF1w71XpIfGuBka4zJL46ICVLB5YrBcW6C6XvRfojRVoQy
         B/xcTeqRa0KUZfQXgxb3aticLtsWEzm5GcL8WCtRIbtcZnnIk/edijIHoL+5dg5q8mr9
         qz5hemvO2PTlgzptEUiz9U2G097VJ0RD5XtPaIXPlWu48CdFwd0I8CtnV45yCRSYwkPn
         Queg==
X-Forwarded-Encrypted: i=1; AFNElJ/HYPBkGGuSEsvYDYhxhR0S+fnMEYhWHGBUV27IzWy7DMYWrxnYaz7O24ixm+kljJSLlfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwUI5g/EajFOBfkQ6Icg/xkpM7BfbWHz7RJFTTLGPLH3GmGpf
	2sYgaTGtwip3zRRSdOBPJEWjl/dmbUJnVb8JJRdDOgbqQemm5JAdl1st1nQ8HWHcr1QvD0CmwdE
	FlfTQeQ==
X-Received: from pfbcp15.prod.google.com ([2002:a05:6a00:348f:b0:82f:6658:1e84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2eaa:b0:83d:446c:498f
 with SMTP id d2e1a72fcca58-83f33c31a26mr17070472b3a.32.1779151456648; Mon, 18
 May 2026 17:44:16 -0700 (PDT)
Date: Mon, 18 May 2026 17:41:08 -0700
In-Reply-To: <20260313122040.1413091-3-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313122040.1413091-3-clopez@suse.de>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915059425.2225644.17432947565814695627.b4-ty@google.com>
Subject: Re: [PATCH 0/4] KVM: VFIO: use mutex guards to simplify control flow
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Cc: pbonzini@redhat.com, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Mar 2026 13:20:38 +0100, Carlos L=C3=B3pez wrote:
> Replace several uses of mutex_lock() / mutex_unlock() pairs with mutex
> guards, allowing removal of all gotos in virt/kvm/vfio.c.
>=20
> In this series I also include a small refactor that allows greatly
> simplifying kvm_vfio_file_del(), and skipping an unnecessary call to
> kvm_vfio_update_coherency() if the list of files managed by the KVM
> VFIO device does not change.
>=20
> [...]

Applied to kvm-x86 vfio, with the minor fixup.  Thanks!

[1/4] KVM: VFIO: clean up control flow in kvm_vfio_file_add()
      https://github.com/kvm-x86/linux/commit/9a7ff263922e
[2/4] KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
      https://github.com/kvm-x86/linux/commit/40f0f4bb6041
[3/4] KVM: VFIO: deduplicate file release logic
      https://github.com/kvm-x86/linux/commit/3b20a19c592d
[4/4] KVM: VFIO: update coherency only if file was deleted
      https://github.com/kvm-x86/linux/commit/156615264fd3

--
https://github.com/kvm-x86/linux/tree/next
