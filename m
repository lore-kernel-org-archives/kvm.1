Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC33E51C9
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451854; cv=none; b=JHhZYg989GTGTNwX794n+D+5P1ZKaGJHQbNenr3Ja39ympLYQFNyvuw2luLdYzLmcAmE7jhX1e9dWQIBN+knBvUtXGD3G1idQG/Uy3MLZkxs4AA2qCslLC1T5+/epEvsJ0av5l0kX1Z1XSM8Zrk2oZzbgLERV3mLa8ivqvjfgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451854; c=relaxed/simple;
	bh=v5fU6a5evHIOX5BkRhykGxS1+rTZ34jdmf0KRrrXtc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FdoNPlDXFsNtd7yTC0phNr3aT2vLoSUa3J9cgHvA2tEaUeCE2yuqZFUv+2FvAp4DkzAEaEy5IEoW1FDV77oV//X/n+NvFF24+ClPtIXgFEpHEdkZ2YYYc9/wj1XvVu2gAqkFoTMXKc81W3/9sdTu+wPYgRWgnNNGm3SggBEMwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AE3GClli; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AE3GClli"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so49126505e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451851; x=1775056651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPDUxnutXePrc/HTKjEYwSZo7PAefB6IwoET63e9G6c=;
        b=AE3GClliQuqhieRUf4uX+jLK10itCLtbAaDiDtWX0KC0PGt2wFtzh0A2GA9u4x+vxa
         fJ8laqzkTsCqOLNgq3cJGCn6+fQrsSLiMVC0QpqKDcDSv7YKPDKj8OSdMQFGUBe6+LIS
         j+q2e1wXZTqiK5LrcG3+hYgVTO7Hb75Vjd67Up/quu/V0WhKq5/3ggXBsKjCukxaOvjl
         6yVB1beOKS2BSlJ58DMVxjN8MK/8ibXD6JUKuYOS9txFf/T0h/vaWzK8+j8ujyRNB9BM
         MMt07cTvvWdv1/vf+921eetwsMi5LtOC/oWDx3aSJIdZK+R3fg1vhFStBgPu8yCR5XD1
         Z8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451851; x=1775056651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPDUxnutXePrc/HTKjEYwSZo7PAefB6IwoET63e9G6c=;
        b=lq0UfYKv9yL9Z/L+ady9mF3pDv+LZp+oNebru1OiWK3D0eRU2/EjaQn4edeuTlEx0X
         e/EN4j6/GmbmINViza6awconl+XVbNvWCD/T6xvPnrYD6XR1IMw1XCkmxVJ5TQFJbl3r
         vgB46iJDhEUUc7wzSAzioodDF4LcXepYXquNBgRWvuPocbXcaCjg6PKZc8aHmJnCWO85
         UWDzCsUj7as5hBGYEFsDXX+KaOQqL07Fl8T2Yi6rx+F0mZiOaKrOqhTcdbXr/UcAYkIH
         /S3MfFsV53tSby/b+764Gb6eHv4RLBKmH9PPRE6pgK/J5tnrNJ2ZVFpctbGtbu4oGq2r
         nL/A==
X-Forwarded-Encrypted: i=1; AJvYcCUO+Dm0PSCx+wcFIsBIDeA5wb9OENL1SPqmsn4mWVAfOFwQ8mxIb9bieFDjda3pAg9AxDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJBp4199s91Leu67JSqOtN0fTn5gJQjAK0VSx8YfelCIfgo+h
	yFzhnz+C4M+EvySYNSvwBJcCpCVopDtx4ryUPXJ6CGthiXQruM/mwPDY0w5PtkmPHX8=
X-Gm-Gg: ATEYQzz3M/H0F2riBt1baXKdAsY+IrOXOwBqapxrU2VnF8KcfUH/5uwqkpYBPqrZ0n4
	OdBGqO7Cllwpdxh10YS5sFWE9b17drIn9U2oLHvvhxHWeQ9dOh2hBJ7t4Se0DWDJrl9BkQuEQf+
	dR9JEBoqiOY4sB3RDpE2oTBthUaXxbp3xmStWlGVVpRW7M35u7EDVIb0WB1dXW9TgbqiAR9pAxt
	MNEKiMZ8suykvstbpW+gnhDQ7ERTpIbda91kN6Fpo/Flv3EBS03FgGAdpejCAerYUZ0s1Mj3ZZL
	Wvc23dwEge6rF7GnADbNfTgfuXq3xKhZEOKah5ABcctGVgc2BUoaboHTZsFQcDNCjD0hiZ/TDwt
	kM2kKI8KddhODuHaQXNRdc6WiZC3rYEoOE0AZuuF3Aodcm+5M7hVCvDgTnIiQYi4r5l26VMWtMi
	gsmg3x4urxwfCGH+hPSPBtHaaIZ4vxT0/8UA+HCf7Ouq17vzlaXkkltOJykjlIZ/B799jvaJfe
X-Received: by 2002:a05:600c:8707:b0:486:f8d6:5dea with SMTP id 5b1f17b1804b1-48716046e04mr64235355e9.19.1774451851290;
        Wed, 25 Mar 2026 08:17:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487173a8d28sm22153735e9.36.2026.03.25.08.17.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Mar 2026 08:17:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org
Subject: [PATCH-for-11.0? 0/6] qom: Restrict compat properties API to system emulation
Date: Wed, 25 Mar 2026 16:17:22 +0100
Message-ID: <20260325151728.45378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Remove QDev uses from QOM to help build the guest-agent
binary without pulling in QDev methods.

After that only util/qsp.c is left (cond/mutex atomics),
see this thread:
https://lore.kernel.org/qemu-devel/a547c29b-3ab7-42fe-889a-19668bc9d090@tls.msk.ru/

Philippe Mathieu-Daudé (6):
  MAINTAINERS: Separate QDev section from QOM one
  hw/core: Move compat_props_add() to 'hw/core/boards.h'
  qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
  qom: Declare compat properties API in 'qom/compat-properties.h'
  qom: Restrict compat properties API to system emulation
  buildsys: Allow building guest-agent on 32-bit hosts

 MAINTAINERS                       |  21 +++---
 configure                         |  64 +++++++++++++----
 meson.build                       |   2 +-
 include/hw/core/boards.h          |  11 +++
 include/hw/core/qdev-properties.h |   1 +
 include/hw/core/qdev.h            |  27 -------
 include/qom/compat-properties.h   |  40 +++++++++++
 include/qom/object.h              |   8 ---
 accel/accel-system.c              |   1 +
 backends/hostmem.c                |   1 +
 hw/core/machine.c                 |   1 +
 hw/core/qdev-properties.c         |   1 +
 hw/core/qdev.c                    |   1 +
 hw/i386/pc_q35.c                  |   1 +
 qom/compat-properties.c           | 116 ++++++++++++++++++++++++++++++
 qom/object.c                      | 102 +-------------------------
 system/rtc.c                      |   1 +
 system/vl.c                       |   1 +
 target/i386/sev.c                 |   1 +
 ui/vdagent.c                      |   1 +
 qom/meson.build                   |   3 +
 21 files changed, 248 insertions(+), 157 deletions(-)
 create mode 100644 include/qom/compat-properties.h
 create mode 100644 qom/compat-properties.c

-- 
2.53.0

