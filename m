Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884534405F
	for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443751; cv=none; b=W2APngzqQj1aMEfr+LhF0DsJFT01HZyO/asCXJZQ1qDspQ8B7p94rasavYjXF/LfAvrz1xUwJ7noTxSYIjMhWS8CuiL5r3OrDanrk1IGO6Cm0EN0zITLCb+sA+bZoZaQQ09jmLzbKYP5gZcRK1AGZARQp0KLJf8tXjgb1lkOmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443751; c=relaxed/simple;
	bh=vBUAyAbacjfaRDxMQvWcGcFT+qxiW9zxnAxYnB8luFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HKjrwMP6m66cHo4Na9McSLpSamx/d/n3UaCX58+cTLvkSW5A4DkVEoGw5UjFfcwLI8eRavpceHSmp6RPOFp82GQwVZVr/X4RdU0BNzII58ZYP+jX4xSmalqgz2x+yfXL+Bi2MgnsWhmItG4Qx/O7OkQPxf0rkX8ptaipFoAfKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjQn17HR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjQn17HR"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c713a6a6f8so26346085a.0
        for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771443749; x=1772048549; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD8Ttwe5Tegj8OFrv2Q7m/YBq2wmzpAVQJC0WJWjYy8=;
        b=CjQn17HRj3X/6EWj5CXcQ0H9x53JVgbuY0D/q0MFNpOUTVvhQ2E6vzdX5I9y9fvWy8
         slsYnId9NfVii7PFzTi7XHen8xKX5XrWTutUMLnpOTR1+rYqFR+3Uh2sWniZRKgj+43C
         fCzcx9ZvtzE4mDF5pjGYLYH6tj8dEw16M3wJwiIdewLfFbbTKguqmF39lzOrt+kCAe8v
         A1pgz3P7+dUTIqhF2jCfd8lyjGN9ZaYmeLF7oRPYo6Cn8vKvPiHtqpPapYGFHeeHmvCv
         D+C5zeZfCTS+bAinu9/Y9tcx6sNFqDdaB0YzRmt1sx9vW8RC97iiVggH1G62LIICaSjF
         nauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771443749; x=1772048549;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD8Ttwe5Tegj8OFrv2Q7m/YBq2wmzpAVQJC0WJWjYy8=;
        b=YVU4x+ZVbCbInRvO+icYo6JnhnNclhKc2ELfnLnN/YH3gLlsYJSxOZPElVgaF1ACGo
         F9aTJcPhQP7tgODg4YaFKQpQvKQPUrJaZ5t5jKx8Ei482wh/XuUQUY2165SB3+VIkhL6
         KO/O9qM66naNxOA7Exvnh5wDmpWhYD+czOmVxm6gb5fELAQZxF3nDyo6wZa2dWlCRO/1
         QGE5nAY6qSUeXPQuBEoyCw12fI8iwGP39xZK5xd+8s0f+6Itjdi6s7WOhEoWueFBMWRJ
         J1vQUOAh54/i5L+qTPImeEvQRZyyC7Y/dbFd5MsHR1wENCq6ThlWjNmJMtcqQ1ZXGnMn
         yuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxgU2RiA33DgWiFEjUv/LIKUsEmf78EwdYoJHStk15kgbNdvB6ZAVByKQm3aoXKu8ubTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuadn6dwpacaZ9ZB6Qb6DKk15Q75hw9tJWj7chcHHmkdTwOJ6U
	ziHpUGbPeITN4+5Glq1OBiWxnOxs8h+XELcOs6Cc+PsrZ79FpbCfK1Jyrs++fg==
X-Gm-Gg: AZuq6aIwr8Z9lWRr/mE1X19Z2iw/53dd7rggrA9NFNxwW67d+7ZILF4n2l+dtpaRbAg
	wUxzk5c7rxLM2Y0bvnZd/aSO6bhuFS3agpwR9PGlvs3vw8UITcfKvss1bMowTB1iGDzaOhowPLw
	F9dY7CuQ/lMdUXHbN2AX+Ly8lF4+kPtBgvJ4XpydeLNU6viVDW9R5UXT5Ir2DpH2/fA0xZOINck
	G+ApgWpJoYsVT62LPAE8rlGGX0eo4yS1t606qYuZahBK+s6aq8xAiFd2xELfRDis7XNJcvThhXJ
	I8Vupw5uKIc6/5Ont41DRWXcACjGzYlGtJhHNweKZqF+xmvO4ZUWHM48qwWYWL53/WrwtvINpfI
	oLJ/DnZFJqvWkDDHhSWQdbe586bUQjG+U8oB+mAi7XOdQtM/UgoGgNAK3BJpH6Zl7KCZfMkHTP4
	akSCvVY0BG/QW4GTsnKyPjVw==
X-Received: by 2002:a53:b118:0:b0:63f:b605:b7f2 with SMTP id 956f58d0204a3-64c557eae43mr2160180d50.10.1771438271298;
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fb1d22sm6051799d50.17.2026.02.18.10.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net v2 0/3] vsock: add write-once semantics to
 child_ns_mode
Date: Wed, 18 Feb 2026 10:10:35 -0800
Message-Id: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwAlmkC/33NQQqDMBBA0auEWTsliWKjq96juEjjWIdiIklIW
 8S7F3KArj+8f0CiyJRgFAdEKpw4eBiFbgS41fonIc8wCtBS91KrK5YU3At9wnfkTBi8IzSm7eb
 edCSthkbAHmnhT1Xv4CnD1AhYOeUQv/VUVE1/0aJQoVXLo5WLNoMdbhtle3Fhg+k8zx//dlzIu
 gAAAA==
X-Change-ID: 20260217-vsock-ns-write-once-8834d684e0a2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
X-Mailer: b4 0.14.3

Two administrator processes may race when setting child_ns_mode: one
sets it to "local" and creates a namespace, but another changes it to
"global" in between. The first process ends up with a namespace in the
wrong mode. Make child_ns_mode write-once so that a namespace manager
can set it once, check the value, and be guaranteed it won't change
before creating its namespaces. Writing a different value after the
first write returns -EBUSY.

One patch for the implementation, one for docs, and one for tests.

---
Changes in v2:
- break docs, tests, and implementation into separate patches
- clarify commit message
- only use child_ns_mode, do not add additional child_ns_mode_locked
  variable
- add documentation to Documentation/
- Link to v1: https://lore.kernel.org/r/20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com

---
Bobby Eshleman (3):
      selftests/vsock: change tests to respect write-once child ns mode
      vsock: lock down child_ns_mode as write-once
      vsock: document write-once behavior of the child_ns_mode sysctl

 Documentation/admin-guide/sysctl/net.rst | 10 ++++++---
 include/net/af_vsock.h                   | 20 +++++++++++++++---
 include/net/netns/vsock.h                |  9 +++++++-
 net/vmw_vsock/af_vsock.c                 | 15 +++++++++-----
 tools/testing/selftests/vsock/vmtest.sh  | 35 +++++++++++++++-----------------
 5 files changed, 58 insertions(+), 31 deletions(-)
---
base-commit: ccd8e87748ad083047d6c8544c5809b7f96cc8df
change-id: 20260217-vsock-ns-write-once-8834d684e0a2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

