Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F81A9B24
	for <kvm@vger.kernel.org>; Tue, 25 Mar 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943074; cv=none; b=YO2nhXOTA1ondAUeAZD4eCTobdG4s4FAwOU+zd1tu5lko9VHSWM4h1Wi1OEsy3HQWXS/eZutflLsT31w7rPc+/M57PsWOXwjPdni4nSPQr/+xX5pkU0ZaRFqEGrkKdu4CSz1nUHVgm+Q/SJtKamqHR1aGmOkmCI0wu6KXErIC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943074; c=relaxed/simple;
	bh=CCGz3+zobApzQyVtTVLrH+hh+bHEa7iMAWzGZnuESp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r8aL1qjfuz8wONK/I725qm4G44jf0tBjpzphINqnWy5RA+YfXKeHjrJZr6NnWcJ2+nbV2OsHxDeDFSwYTVSdHW+GpnQrkXVB7zHj7/0m/drjZCIlllUl2o6UYpypIKn+wImLz1LBVJydy676C2i+pqFuWNZ/Xft0yk0vfTE5YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxNtYwXE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxNtYwXE"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so10249276a91.0
        for <kvm@vger.kernel.org>; Tue, 25 Mar 2025 15:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742943073; x=1743547873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCGz3+zobApzQyVtTVLrH+hh+bHEa7iMAWzGZnuESp4=;
        b=oxNtYwXEHYzK9cdztDUCt4oWWkBhIL2LYxKWwzwx+GQJ/ToyJNZH6QWc7LTwQmHQLE
         hOEdXZnejHDDTQ8twECsuRiRVcRvsJCrJ27ZlY8Rx224HkTNcQQdhgqpuu8pdZQfMy1h
         g6hECwq8a26ieCbw5q3Yx5kyrDeziQ9T727D04sqMzJHEytWofNOBm5zxpKGgCWh1hM0
         WDqckXWQO3xYyJ8itEPsYEGIU+G6/HxrS7bS8rb5x1EBBvhH+dBZKW90otGT0ii+6zQd
         vBwwo/RPYkxVMDVKheoZHwKa3zIXBdftREiTDooba+5oI0VQfnqnRZvNTq9rttQBFBK8
         X0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943073; x=1743547873;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCGz3+zobApzQyVtTVLrH+hh+bHEa7iMAWzGZnuESp4=;
        b=BAfEvDZlmuokCmb1gvRLRFZDnFMdItcRfMEYxp9ckFKgCwt+ThiqT0/cvrd2p7Qnq+
         xHpz8Cx0esnml0/x3Hr8R+G3rmBLR5iyf2rmvKq5nyRVoEimUkkiaX+upG1UuHxMBEb0
         k1EH90lizck9O0cj692YCk5313Ox87d77/tgDnWMVuajCDEReMhD9oQMA3q3IIGb0cnw
         CrjMHQb9SZpGEz7OqO0gU8JCelQufy1wh2Dw4T1WlJvNpAsXIJWEBdFvreEzg9QsvvKB
         o7ipOY83Lg5hgGniorkxDNlwnNVIFtFKbj6usnd/ea0eWqKPbpX8XqTqMyMSaMpEQsFE
         p7Eg==
X-Gm-Message-State: AOJu0Yzep02qQOs/QImqPn3IplqmJz50K/5063gFSLT1JSlUDwDRA460
	7cXI917Htz2a0xqr8cX6MlvoQBgjmswvZgGIeOyraV3dNAA0LosRkDryCTazROKX4p9jK25EIh6
	PBQ==
X-Google-Smtp-Source: AGHT+IHYTk5HZTr91hcf06j9nnJIfVo6oiWibftCNtH/6yykV0si7/iIGPC1/rRmh15JykuM0xe0O65nx6s=
X-Received: from pghd10.prod.google.com ([2002:a63:fd0a:0:b0:aef:56d4:b718])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4c85:b0:1f5:9069:e563
 with SMTP id adf61e73a8af0-1fe42f55966mr33188525637.21.1742943072674; Tue, 25
 Mar 2025 15:51:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 25 Mar 2025 15:51:10 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325225110.187914-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2025.03.26 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reminder that PUCK is canceled again this week.
