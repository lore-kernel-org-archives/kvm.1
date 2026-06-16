Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEA344D88
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637655; cv=none; b=hyRXUlLja9VOc9GHtE5dUbe35SGRAhYcWoz1WZD+Vd+2bTxwXW6X0m/VKYLdRY2KfGW4VBuruRzCpk+xbnCa9RuUC1DHLUueDtjka/+pLVGHACRObZYK4z8lglxLDiPaZ1LrheFvO9CjqCV5J55AnrhI5/yKWwe7ZVq6QlWYHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637655; c=relaxed/simple;
	bh=UogYtRqBiVjHWJC7z8/Zh+EB+hJzxz738BDN0Q4YOLI=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=j4D8Td/zMD20wndEP/BCuZQ9fvnhKLq+3Wqh8ST8hmb2A7v9fBqcKPPBhkgJ+RCr2UTtaZff4Tyy4M2qnM2jfffw6qGPaEnT7rzJW1VIGlX5Ndei2Fnddpn5Nv9Ya0O5TqjcV//3HzJ2fNRbUZxShZA3QP/bJBW+u6L6nT/9XSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/D1xLSs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/D1xLSs"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so34691795e9.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637652; x=1782242452; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UogYtRqBiVjHWJC7z8/Zh+EB+hJzxz738BDN0Q4YOLI=;
        b=a/D1xLSskEHJ6vDjpmEy2sbPeLwt/K2JLH1mz//JDmLUvYSJgW3KnEIO+8gFUMgXFa
         I8C/AhSmq3TSMbgc6tG/IPkG2AAri6+OYwwcS7qhW9LhyVwTZshET9eQafTINNvJG7ol
         /K5RzK/DXmEBfEUkozKWu2UIBB//zcbFTJVnTwg7u2E9KIiCUtV1B44S/+UGLZ4aXlFI
         9BZE+IFtnUcHjd8p52gXbR8a0thhJHT4/Nuf415pbSlOCegl9DbLueg/ZW5N+/JG6Z2n
         65hLJ6dIT1siweVwQTk8Nw1dauxtaN4TcJXKwSr9AKLbJjgO4iqjSqt6GeB7pw+crPRE
         k4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637652; x=1782242452;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UogYtRqBiVjHWJC7z8/Zh+EB+hJzxz738BDN0Q4YOLI=;
        b=ZhN5mjZcl8cKigE+RGrvzO8qVR+WnRyUGyKc0rpH4MDjrpB78P6gnTuJH0m2mV6Q6g
         ldXKf/LhpUc1HjCCz8cr2AGauNHqbieY0HEf83kz6UCkAw4WEAxLFkQcUd7cCcpG2LI7
         kdAGrJt8yv5/GOEEuPMTnul6sfjkI6pdsnV5PWYDZbBQjChcLz30asbj0Ul8r0uaofCv
         6Y0YB+ScSOviXZLsOJWsWlN/g1DIQMLBR2ogAsfclHhFsAJn7aTj/GzPUJqnEAcIzq/B
         mOdA3dgbBnR4I+T52jjKuMpcTaWO2RGxry815RI0O5wMVOFKsINuKF6enfUt829UNBgh
         BlfQ==
X-Gm-Message-State: AOJu0Ywca1auiY7u7dUycHGSnw0FAOwXJf0YlmSWQDZ8m8EeZzFZ+uZv
	/gxxSC28X5+TMb9t7FBEeswo/HNb9TPQneugZPxkjbeHPaspRHAwxwDAVcGtel9WMXM=
X-Gm-Gg: Acq92OFG1mb1c147xHiNaswB7UyK3WmRDNm594a+OjkcAfF8CWt+RtD/Wnn72F1bGkf
	1ieMMhpdU80BxUut1Ji2x3APK+AspcUSt1dvUhPHPd6WMTtzew0rcBLWDt1ZcCMMW6CwdwYYBJR
	PnvGqappCVQMmdp3MzJ7Wd9nknZ9GSTbcMA3dvSErM5MTz36pSts5eUGSlukThxL2QYiAOVhcuv
	LQIs+HYzpvD9QZwoB0QZEQbAJj95jI2hLlvXAE8ar6XEppZKe29qcFPuaOZGDAhpTJF2UX0SGC6
	R+Bl4IHbDhJeunVyZsRcog691LhXzsUmnFByptNW2zdk+gw8yCdqcIpH4NOoIYXF+Uw0pDG0Jao
	7HsBYO9Jvkksu80KjOgj6dFwSeMeKhGj07+BJNuO/FgZKOuFKxbVZ5z3rDmMlAf/JcJOpyOtlLN
	f4v+mJwaEAAb/5G9dsFKx1+9/p0QB7dA==
X-Received: by 2002:a05:600c:e557:20b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-492333e2b9dmr9754405e9.36.1781637652268;
        Tue, 16 Jun 2026 12:20:52 -0700 (PDT)
Received: from [127.0.0.1] ([154.80.21.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ebe3sm69297095e9.11.2026.06.16.12.20.47
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 12:20:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: Donald Marvin <gbchhgbc@gmail.com>
To: kvm@vger.kernel.org
Reply-To: donaldmarvin.pe@gmail.com
Subject: Project Takeoffs
Message-ID: <bbf356ac-7d04-a656-f5f0-037d020088f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:20:48 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

It comes from City Estimating, LLC

We specialize in full cost =
estimates and all related bidding services for all construction projects in=
 all 50 states. We provide our services to both general and subcontractors,=
 as well as owners/developers, architects and engineers.

Feel free to contact me if you have any question or want to see our sample =
work.

Regards,
Donald Marvin
Marketing Executive
City Estimating, LLC
