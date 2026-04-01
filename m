Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CD2DCBF3
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074710; cv=none; b=dlBD819oThkeg/lNn6D1DOf9CemupDS52GBc4D9sq34v3iEDQyzuOqhZ4JAjs0eXEoxy2VVqS1vYxhiV/02T9vmvhA0gd2oZNaL+4fPX0iLD9GCibPDSOv9DqEKi7Ep8f2+hGoH2SQU0wbDwHDATKSmFWQ/1mMnAXZsSTmw4Ld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074710; c=relaxed/simple;
	bh=9lonrmz2Oj+AlTTr2Ep1+PMhz7iB0jqbo4tLGpzXkfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYvfHY04AM01Y2tsXnSaqY1stXXq+XcOFq0vK7Ns15VOZo58f9wW1qB0BgleS1kbeS1k7NxtMuttQ8oOD/FCsWoiyKHdWa8M4BkWlyCG1H0B/+RgCjQt4YGucaVaxujOYuIjVDkR3mMmT3Rvog0l7ZRzSLWCLCLHbJpoFtFT7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYxWj0EW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYxWj0EW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d03db7f87so105379f8f.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074708; x=1775679508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zFCy2/f6gXgpLVosgl6P0mdggO0d7nONWw8yr+5Eo4=;
        b=pYxWj0EWpFipQSlUlYVim0G5C+c0+xHzaz4dec8UYbvTLzGxUlbTL98PdX8h2EOAbv
         i5FPRvt2XBFhsYkxOOXUVNp1QfF4UO6yC/juYYSGPsMMUSFiqKnm3QPwKkUy+4XrQP5w
         KbYffWCHbg2mSx7Zb4rmmLE9e3avKx6IUG0k9rstyYvlkefAhUdGHWTn/MnxWO+Xqh6G
         tKN7vBqAosY5JV+knXeqdY3vCf6ph/fqangNxdrhRjYu8liVUbZDh1EUZ6HE+oAjonxi
         YLi8I0LWiE1DIWAPBIVxVsfauEbGTMf8cA16U3Q2Ias7biqGMUaiOINvDOGu+bi8udeT
         7EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074708; x=1775679508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zFCy2/f6gXgpLVosgl6P0mdggO0d7nONWw8yr+5Eo4=;
        b=ZuGaFDXrflLfYN52qRQ+8Suhb+l8KXQxhV+oPJPPemQkCLZW3A7VUbtEL+F/8FPxhS
         6cVk2AEddyuCN5eEZRyp3DJnFxXcVb2keUvK6meYbZPeDPxLiUBU0JfYPD005yUprBqc
         fwXHziHwJmtRaMUl0zRROda7xkrZiuan5isCGj+KJVCSeXXrao19I/+blNizfWMypGTj
         2qvV4u1Bb+UUJRxyEUx3hvaOZVviZY9xXJr5jaDCw9KKGOVw7mZYT/Ej9t/TUqGQiXFM
         kCxl3Bqfk0MQWmDfAsKFFNAiPMu322qqzfNsoEq23jVsVoOCtY6a9HWJncuiFWR6OXzy
         zSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1MB2uXA0KA0j2Uzew/V3CPdslXkgeiiepvLucL7X1yJc7+q/D9EbCoNdAdWF/+1R8FfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHcusdGlZEafVjNaeTpw6ded30g+29FZJwY71+Y5Cw42JhoYW
	QB7bX0/SeLXDsoUhPf1+O9XXKwS8T3xVBnBQm9+YRXPWhc56nIMSMwS3n4Iz2jTjds4=
X-Gm-Gg: ATEYQzwrUW5g1lT/J9IFl3P/HJcwy253rHq3RY2fxlqxjzfoDmzuAcYjm5To+Da9emN
	2RXz+SigI0aJ705or9eenhbFHuglpWbClSV0eJ7eUhcA8E1fmk+DFBaiuzOdcYKTh19l8pNB7bm
	xmXt3i5IZMdp0Aq3gvx3gDWmUBcON14QgXV41L70jOYj3rzexSk8+fM8neCgUYFrG/sBaZmNI1a
	zDbwqH5uXDnPqstWPkr34oHl9nIUVLkhmibFCO9VbdKFu77DvOXiCpa3p/4kJa6mWl8q8Qxefx1
	hiHOPSCY7KqGXchgYtPNeJ+hisvHuC3/6H8CZNlkFRrbKEGdTS38Sxa1ABIRtJn2q3+oxbrx0nE
	Uipeevj5JXni/YaY4So4e7MdX6HNcQdHxoOXaJdSCs0A7vDoAB7ogE2O1u0R3EmgCFEOVzdRicN
	3NgBJ9pQtPQKKGF/AJ6NfmRMFWFeMlXO81stbxrT8qd8IiopT2dV/KDbd4FfHuh2U9Qb9rRXr2
X-Received: by 2002:a05:6000:1a8d:b0:43d:131e:f74d with SMTP id ffacd0b85a97d-43d150de841mr8704518f8f.44.1775074707594;
        Wed, 01 Apr 2026 13:18:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5468sm2487593f8f.13.2026.04.01.13.18.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:18:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	qemu-riscv@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Anton Johansson <anjo@rev.ng>,
	Song Gao <gaosong@loongson.cn>,
	Weiwei Li <liwei1518@gmail.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>,
	qemu-arm@nongnu.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 4/8] target/arm: Compile WHPX as common object
Date: Wed,  1 Apr 2026 22:17:48 +0200
Message-ID: <20260401201753.92290-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401201753.92290-1-philmd@linaro.org>
References: <20260401201753.92290-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

whpx-all.c doesn't use target-specific code, move it from
arm_system_ss[] to arm_common_system_ss[] to compile it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/whpx/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
index 3df632c9d30..db31e928012 100644
--- a/target/arm/whpx/meson.build
+++ b/target/arm/whpx/meson.build
@@ -1,5 +1,5 @@
-arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
+arm_common_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
+), if_false: files(
+  'whpx-stub.c'
 ))
-
-arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
-- 
2.53.0

