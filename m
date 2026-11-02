Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633223;
	b=GrQzZEjNoM8ay2T9+kY6LCLfMOeRfNmuNWmF9CkPawXVynXLYi7AfE8vdmAnWVghCEVK
	 0fTiPMc1BXW80TqU7Z06ziOZWE/nUcjtNYlvjKMoLoT8XVKwdnIorXLHzJfXE4+N5M0x9
	 kaoAZBblurPpQXGkho0Od6LKO49P1kQnDIqhotJqITh7ttpy++99vrzT9h/4D2Z3aD8e1
	 UHc0Ym5SMd0kz2LMVwuf1tURoyAuet2YjwOduXDtHuV+ZFuxMWcem2pQia9U6yAbFjdZJ
	 x8oF6q4/zThwpUiAY3ZcxlN9zLZ+Uw4KbCR5U1TDMtikk5f+Tojw5YciGXkpHKjuLSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=hBo6eoZILf9FXsA6KADnqw6aBIyY/61Jx7TtUC5p3AU=;
	b=lbqsy/4QQwOh+KpLYKEYewK/bs1mtAkTL7YynxxwoPXdWZRsNLtpSAa9ye5RkcwcrkzU
	 eZOelx2vaWu8f3pwxnqmTh/7HuHjLxYMJYot4IcsWlZbI2a6oayLUwL7c5UIt4X1DoIjr
	 abLtTE8JBrUTa5uk40ksdMrhfI1VxqfBANxMISWtH81tHJ4iatuThEoL0dpl0HNLnUsU4
	 9s6NGgQ63O5jRVmUiWwW5RgsGh5y0UALO/IOLRok35Od4f5PCPAM6JWH8HmJiu/ZxUpnM
	 5j0K8pzvGNsQg0vibKwvyeXfEmVNRB8YWLC7oFoGKwkmrcvVPBBJMzQz3oI5lKaAXAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A6jCZPDB;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090F6083E0F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D090F6083E0F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A6jCZPDB
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so2589529b3a.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633222; x=1794238022; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBo6eoZILf9FXsA6KADnqw6aBIyY/61Jx7TtUC5p3AU=;
        b=A6jCZPDBxAbmWkQ9qFtMNYKomi0aEU6Zu3iaMdt6ZYSTOgbcovAhIDa2DX10WsNyAa
         CehBZmveeOm5atWkZ2TrJDsSrCXFmXtIhngiUWgsaXJEfECvaSmKx5lK4TPgOeEzrwX8
         tvTXKiuNxlsU8dI7JTx7RYui+s4Y/E5CoojwhcEqzF2S4boSm4lafwXDJbrV2V7YGVcs
         8fG2I8APsfvwbOBDEnwdnpeeoLZwAtaQHqqAZQpolO5rNpL0Goom0du74yOsluimxP2A
         Pg4ddrTnFrD1qy1RvXZvBOzEwR1+5bv0UtrNXZ5oaMKFFDj7OGYe2PY+uC89FS7yB/fX
         qv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633222; x=1794238022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBo6eoZILf9FXsA6KADnqw6aBIyY/61Jx7TtUC5p3AU=;
        b=IJ/fP/deKkbbrIJmmlIJsBP3cXLFJChZABaBVeH4WpeawHSS8IGmOOy9jOisBvLhas
         RwF1osVwCl2Pq5xVTuFPd//7NQWhVXHRp62kjJUXrUsZSqzuCOih5s2YuWwB1NVF5HbB
         AmIS7Tp/zoieUDs57H8PggGZsMN/29ck7Iu4JJhSdBtR5yLlQoKIxOzVB+rmbqXyuDuC
         Hcv5Z4delVDNs1XPDyRqtMiC4I8cU/0iUuDfl1DEfBh3U9/aZZ4CT+UYrjTsbBj3L9bd
         D8OZIVI6uNiColJkCTZsPZEtAuEkLC2wO5ywblBpZF7J6DCf7e2mmJaVoe7SgKjTn+A3
         BEsQ==
X-Gm-Message-State: APuU4Z/V5GF/2tAA/PJE9ywlECmHz63JSebckhYWOh0qw6hg/Sgv923y
	KegJ0bWxSouQxOhPym9KM2Vb/rA/fDmCtRSkfYr8rmKgb/26lxIe1X91j2ynxr0ymePgZNwp8cx
	plUiXIw==
X-Received: from pffl19-n2.prod.google.com ([2002:a05:6a00:c353:20b0:88c:e369:e5a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1b:b0:89e:43ee:6538
 with SMTP id d2e1a72fcca58-8a9bf23cf6dmr8004990b3a.36.1793633221862; Mon, 02
 Nov 2026 07:27:01 -0800 (PST)
Date: Mon, 2 Nov 2026 07:27:01 -0800
In-Reply-To: <sashiko-outbox-191575@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com> <20261030212721.2606393-6-seanjc@google.com>
 <sashiko-outbox-191575@kernel.org>
Message-ID: <auirxeLJR8hirgtV@google.com>
Subject: Re: [PATCH v3 5/7] KVM: x86: Recompute EFER.LMA instead of inheriting
 the current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: x86: guest-triggerable WARN_ON_ONCE in set_efer() via SVM state sync

See https://lore.kernel.org/all/at-TP7Il6rWcd5Xh@google.com.
