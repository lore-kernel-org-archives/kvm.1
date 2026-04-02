Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134453B47D4
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131880; cv=none; b=VYvWaQlcPMWw7nR0im1dsLgGJxGKmUQ9L4fT4e1oxVVsIajQlmy9OmK/zCHaacC3hkNT3FwYtqiGDNk2HqtmxvmY8OSpc/3KEeOPV5HDy+RX98O89koa7CLWQehtMoH4WGp3x8eX/aaf5DNZvwlVBNuFRTCv9SUPDNevCBiFvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131880; c=relaxed/simple;
	bh=PM6VIR7gz8+am8i4goLgv+xYYu2fQLjYkRL6gda7FC8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=E9C0vNUSzCRf9AqEWAALBXHi+tB7leLN+ddKGi7zb7NbEiBRjuq4kR6TI0UDDa32F9ZK7m9XAlrUe8dOQxj9noZIxHXrxQPQfl3kQBHz60V3NUSkmGgLUAZXSOMtX86Kh9VQdmBbVR0ba0FTd/tBLnweCTjvYolX52imh5Bmc78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkwt31oD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkwt31oD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so8272165e9.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775131877; x=1775736677; darn=vger.kernel.org;
        h=content-transfer-encoding:to:autocrypt:subject:content-language
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k4hZG7y9nhhpMB94WMMqADvRYY9jN17jXDR7WBkRebk=;
        b=rkwt31oDa34+Vkpb9ORdHeKxqXibpdEWIJz0UHF8SyAWovWWg3lgdBZyt9LvzfTrgH
         osvkO0bkSMSQ/Slg6gHzANqxP3+FojoLwYMeR1F/+CpacslxgMETfbQI7GQDhfS/lCGV
         NbJevh8S3uvbxh4qGZ9eCitDY+qw/pYAMm1UeysTaEpIzv3k4+k+sng0jnthKBTy2ilR
         UjfXq2LfLtU8CKiil9xufm3zwfbaXMpFEg6Z2oqz6piLTlbSXuTES39hLmr1qcfFrVAS
         1x4Wd348kjd77HlKS/0Hku9w26Ml4duIJt7GgDB9Cu+2uMaDfo/uOeNuceYXf6u9K+TG
         waEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131877; x=1775736677;
        h=content-transfer-encoding:to:autocrypt:subject:content-language
         :from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4hZG7y9nhhpMB94WMMqADvRYY9jN17jXDR7WBkRebk=;
        b=oEL1La9ttKsOGowukiDgKDmcjleV9lmlIaCaDAyZ85FmbjVFynsTz+xUmpS8e0kJuQ
         ansU7BZ3fewJX290Q54ccRYrSgJdVrp03YL039/C65bKHnPMWA+SPE/A/978a6qBVSMl
         z9kySuJBs4t4PqespD1ZouvVVUkfVCX9Gd1t89d58ZAQEC6gVnXfmK3GKT5XONe5l5Om
         uEo5KCDP4jmxnHIWlM83aS15wVKn7DqiAyZ54a//HcWsKUh0yM3UIBWmVBDwxNcdjc/p
         ZHVW9sILRKvXMoGVpQycToBkJNVU2dhTlpuiECJiFoDb7EdKuox4tpTb8zSRLjwMEsnm
         /PlA==
X-Gm-Message-State: AOJu0YwyvXdcupAcc5Nd/1tjrbyzr9BNqSgx6XOSEPM7gcqxcwxnaACg
	2jw7KT5hXSg934UDAAxqWtfjoxxc2Sfb6BkyKElO4FlqpTRTY0kOhT1LxISFnSDyvK4=
X-Gm-Gg: ATEYQzzbM/YyWL53EO6tf+Eq1+tpIN6wFGS/Bf5be2w/xqq34rOAXJ23FpO0jb8THn3
	ct8dZDFr8tJNguqg+iSU1muB7e8fujdaXtWnOHtlzA16/Arpt1/q1KYnAtDNgh95FsPv6A1aMgr
	pbUXlbHgrmzA2nJvqKUS/u76Mipy7Bc5zVul3ABKWy859bhh4eoHlQy+2BO6T/ffWPnof37btxm
	NMw4XfOYVgU4Rk1KGOmYqGuNJ2g4+ZQztC5dF4iTOderio/BNRzTIWJGyAFRDBCl5A332jBopza
	EWEYtH8d0Kxe80gTR8qLa+/E7jeI0m93dCoCST1NRoRhbq/irjcnNMyClhs0yNbg3oGWIZFxtoR
	GQzx9Jy/8hYVpjYILLamnsi4cbNWRUMwWd+GYxxOwVnLvjSHoXwWdZtGYI7VFAcG7PqztB6jQ5G
	gIfu5wEV0N2KIf9A2QPoO0vyDLaDQZPKzS53eHosZ5Lc1AgBBWQRXKnzpr2JzJ2yIikWZ9WPDEN
	3xmsRUltUhMBhn9jmAmAADaZaaApSPImkPE5Z6Us5+d1E2tcFjOlj11wZJxdoPCKUOMK6RfCRZB
X-Received: by 2002:a05:600c:3496:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4888e0e47damr33863715e9.15.1775131876870;
        Thu, 02 Apr 2026 05:11:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:4f00:540e:67e6:b14f:9ac5? (p200300d82f4f4f00540e67e6b14f9ac5.dip0.t-ipconnect.de. [2003:d8:2f4f:4f00:540e:67e6:b14f:9ac5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c884b8asm62838455e9.15.2026.04.02.05.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 05:11:16 -0700 (PDT)
Message-ID: <39aade54-b81f-4fa4-abcd-615885ca131d@gmail.com>
Date: Thu, 2 Apr 2026 14:11:13 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Hildenbrand <davidhildenbrand@gmail.com>
Content-Language: en-US
Subject: [Invitation] bi-weekly guest_memfd upstream call on 2026-04-02
Autocrypt: addr=davidhildenbrand@gmail.com; keydata=
 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
 /Xn6oe5jmKiMLPx9rQ==
To: KVM <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Late reminder :)

Our next guest_memfd upstream call is scheduled for today, Thursday,
2026-04-02 at 8:00 - 9:00am (GMT-07:00) Pacific Time - Vancouver.

We'll be using the following Google meet:
http://meet.google.com/wxp-wtju-jzw

The meeting notes can be found at [1], where we also link recordings and
collect current guest_memfd upstream proposals. If you want an google
calendar invitation that also covers all future meetings, just write me
or Ackerley a mail.

There is not a lot on the agenda: interaction with guest_memfd and
VM_DONTDUMP. So let's see what else comes up!

To put something to discuss onto the agenda, reply to this mail or add
them to the "Topics/questions for next meeting(s)" section in the
meeting notes as a comment.

[1]
https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?usp=sharing

-- 
Cheers,

David

