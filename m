Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858819;
	b=lFrsKb1FkewskpgTg+EgPQVnNqxPsgFM739uIhwET3J95Ccot7dsJghlxISZgCvbA3wv
	 eQQSyB78zPHDl05M5wlUstc9f5kklCGdra+7h5XqS+ZN3J5uEZpncfmPSSVVMP+uHwWMd
	 LlK1sRA4KzI3By9c48IODurheF3B/hj8ZX6MxucXp6za6r34Km39yYpcL8LLZXv8GUQWC
	 FsM9WYYnIJyQRs+wpkRZT5JB36305aH0cUTqr6uhIeWLbm+BYENOKM061N8vAbpKuXmaI
	 tL8GMhRg6858hIFCP7HYTwijyBDQnm0MdHfJZmmRSOPE+xNNfCeFiJO8EMpDG3+Dvow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VUHwyUVFQivImr/shJ25i+9HhdxBuVPOM8Gs9TPRV6M=;
	b=P+zGAFkN5NsHrHVfiyPy2RqbBsZ220krN5It/D9zGH+AwcHvqzNn6kqtGwgJVKv2XBFj
	 lE4sizO24gotKbaLVOc6iY3pQrYXVV7iCkj/H8XSJm8jp8zFXo83PTJsSvudroKQjC/X3
	 zbkrsZOzvIoosl8uofWJ+QVX5bwJJPq0nCi0jA2BHAzCwR3DOSXm2CSWXf1F5sCkB8LWs
	 5dXKXCyQH5WpzLUTp7lYVdvbpwiEK13aMcVF6l5/MDPYR1K9vkf+43z1Yfkk0Q0QiU2QZ
	 gSfJS+zMdrZ+2cNgTsf/kfhpoJXDxMJddHTcvMM0qH3+N6KJB35lZPhrqQwVGC061GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VTRIsbG4;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D2606A328
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649D2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VTRIsbG4
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so1458658f8f.1
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858818; x=1793463618; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUHwyUVFQivImr/shJ25i+9HhdxBuVPOM8Gs9TPRV6M=;
        b=VTRIsbG4/qWz3jsGgdJ2rYMqgjlO2OlBikWJDh2cqv7fAi2wZuqOQI8YbGl6iEaLUR
         YzSYGCf7Q5Zdf4BzY5kuzoZNo563uhHJ+oUjAw6uH2uXOhq5+3VQi5cGov4p257fpfG9
         ytfrPymxHSDfg8J7LRumd3zDF7LKmA/skCfUMc0uKsDmA6cDMt4TdJJRxXTDyo5rNQLU
         +z5oJVBEEeA2IDNTrvo8YkklqBv/FdMlQG14XuwjzD9UJWw7/3cM7g3yOwQouFjfoXZZ
         GZSWeABGenLRA88kB0VwW1myIECcPiBqRynFoRREL7rDKprEjHpU6NaNd2ymgkS4SxxT
         VyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858818; x=1793463618;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUHwyUVFQivImr/shJ25i+9HhdxBuVPOM8Gs9TPRV6M=;
        b=fsraGx3nZMwPpgkhjCrEduariLUJrirAFUNk5rZmadRi83XplrnmHWc8X1vmEEiePh
         MR9v8wmI7pr4aIAKK70X2Fh6EfKb1CqJ2HvSNJGaukuA8QWrv4RkCVD7LmsjAy1miziT
         VcO1j742vSt29WnjId8QunbtsQg4REsfunT1Kxrrkx/oXMBaXESujfiZF7piIV5DTuH1
         BaChrhv9LId9LjiRp9NWRiA4VM7RMn1mbmBBdgDfzm4qaO9QbVWIKCwGL3pp2W3GH5H0
         eJW6JP0mnltB+g8pFQ8fgsW6nNSPEzC/crLmY4XQ0CDJVw9TlBZ9rv9KhdWLYL5pvsx4
         4maA==
X-Gm-Message-State: AFq9FYJ2ONG6fVYVddxwrotBtciRAoZunv0cbhZ1PHaHwpGDq7k+BwG5
	00aeyh7LBAGtRZww7ieCmXPHyYI2xV/xUbO/cdK8ofRuAHjSalcZ558xYuoDyRKs6Gvi7ads0b3
	n5VdtGuSmsPyF0DdDRP4SaaOO1za5smw0bg6EsrD4I9nfDNQvu/GMeVb2Oc/dO/xgRZxYh0v0Dj
	Z9/7o4N0lilvh40L1AwmT0HmJ8vSp02tl5fU1zTRUbpEw=
X-Received: from wmgp19.prod.google.com ([2002:a05:600c:2053:b0:4a1:f80d:2f25])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6095:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4a35ac8bf3amr33274285e9.11.1792858817489;
 Sat, 24 Oct 2026 09:20:17 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:18:54 +0000
In-Reply-To: <20261024161902.2093581-1-smostafa@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261024161902.2093581-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261024161902.2093581-2-smostafa@google.com>
Subject: [PATCH kvmtool 1/9] vfio: Fix fd leak in vfio_group_get_for_dev()
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

The fd opened to read the iommu_group link of the device is closed
on every path except the one that finds the group already open, so
every device after the first one in a group leaked an fd.
Return through the goto on that path too.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 vfio/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vfio/core.c b/vfio/core.c
index fbe0098..e0c56ab 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -544,7 +544,7 @@ vfio_group_get_for_dev(struct kvm *kvm, struct vfio_device *vdev)
 	list_for_each_entry(group, &vfio_groups, list) {
 		if (group->id == group_id) {
 			group->refs++;
-			return group;
+			goto out_close;
 		}
 	}
 
-- 
2.56.0.307.g5fe7bd680c-goog

