Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4EB214A9B
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067705; cv=none; b=JScnI1lOzkjnFgyg4kM4K4BNHPZwVdEn0OpmLKLWpX3fbpEs/+wE4F11ZzGBzA1iaUBHvtgM1OqKoHPtLnD7TM14WdvSWaYPniG7Nb4rdlCXNSadhkFUBS3ge4S6BxYy5ZFVKTSs2iDgkt6fsU2loPNxXlB/LDbovDNZQUmUhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067705; c=relaxed/simple;
	bh=KxGVVAQH1ziHwtHM7bxQqMhy5tQjdu0B5eTVWk9k9QY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ukkWEVpVeP7tlh9xSXKXvXxX5a9g2vNK9qzDUyVPwDzML6ZONE2c+jpGLBr6acmubCpPQaCRzEXy5j2FgsaR8rKVcpusgUCES46ocgzvUL8x8l+oxRqQvkPb6YZeuId66ChHFPUjDB8wHTgaa3kSf+u6c6uTlqD9bVEHL2Y5ZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7EyA2Rj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7EyA2Rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776067703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3BQ9t6JgJ/XtutcXu6VPOQdYVtWZ1yKAaamJ9ZbD3E=;
	b=f7EyA2RjDQOIeDYOW8svitQnGBRHfLpKuv+TvsmX+x0wr/tuSOyCS5LSlLid3sm2puACp7
	U4RsYZ/YCgVABSQfYesHjxFoYG7gMk8ZZoT/7Qj8n8oQfGz4J7CSz50WbAsODuTtm5Ml1z
	x65PEa3mg4doItwKmXv5HzymGARdE8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-CbAt4Kt1MCe1UpMGu5q7jg-1; Mon,
 13 Apr 2026 04:08:19 -0400
X-MC-Unique: CbAt4Kt1MCe1UpMGu5q7jg-1
X-Mimecast-MFC-AGG-ID: CbAt4Kt1MCe1UpMGu5q7jg_1776067697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C64B1801230;
	Mon, 13 Apr 2026 08:08:17 +0000 (UTC)
Received: from localhost (dhcp-192-192.str.redhat.com [10.33.192.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C86130001A1;
	Mon, 13 Apr 2026 08:08:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan
 Gilbert" <dave@treblig.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Eric
 Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v2 20/27] hw/s390x: Reduce 'monitor/monitor.h' inclusions
In-Reply-To: <20260410195323.17937-21-philmd@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-21-philmd@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 13 Apr 2026 10:08:14 +0200
Message-ID: <87340zcmfl.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Apr 10 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> We want to make the HMP commands available for all targets,
> move the declarations to "monitor/hmp.h" where all other
> are, and only include the monitor headers in the source files.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/s390x/storage-attributes.h | 4 ----
>  include/hw/s390x/storage-keys.h       | 3 ---
>  include/monitor/hmp.h                 | 5 +++++
>  hw/s390x/s390-skeys.c                 | 2 ++
>  hw/s390x/s390-stattrib.c              | 2 ++
>  5 files changed, 9 insertions(+), 7 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

