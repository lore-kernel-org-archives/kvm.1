Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EC3A4F47
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067841; cv=none; b=ORyn3morNkXz5WqyLcNyIxNeqDFzI6uv/nmuQhZa47WMX5LEnbrOM40+TyL4h6KoCFWAfpbN8YYBPU9kxx6XPCRzg0ExvjmFc2YFPZnBS2Sshfk24CYPR1RWx67k2Gytkz9R2YU4kS0Ax0lahhI75s5+buiLHucU/2Yi3tVAyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067841; c=relaxed/simple;
	bh=+qjn+FDtPNlFxyR0pXlZI3VP8bmOBwLEnL6R0fw5+EY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DWPaXx543oIuaBxoDNzAfAJOhb4AuubFrIPqk9KKDrJpJKXKGDGPoQ1I5f/UaaevxuV4AnaL+2u5lMQoitdLOtGaWFS16Bsil663O656LPIMwNDiu8JmdchdOQsaknk3ZfbKDjqdPjrSgb67oZpmM1N3237kLj6Dx/9wxreZHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXAILnMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXAILnMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776067839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBy1Z9iAFrwDgubE854sZbP4t6wpVWhVvni7i4dtyXA=;
	b=IXAILnMHpbgTrNDlnLXLnheJaEbrs+Zmor9EDMz9AaWlEhjpXHXvCIm1XqhIMnj2VhzcvN
	3VlGtWg7gJauw3ilZyI81kbBR2YkwYfxzK3SoMhlO2OWnjNiY4qZ/Z7WlHoEYy/5I7CVsx
	vXgRc+BEEKWg7BDgOLvi7Mutx1vHrhw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-p2UB40wqM2GMkQRHEBcGyg-1; Mon,
 13 Apr 2026 04:10:34 -0400
X-MC-Unique: p2UB40wqM2GMkQRHEBcGyg-1
X-Mimecast-MFC-AGG-ID: p2UB40wqM2GMkQRHEBcGyg_1776067832
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 410C5195609D;
	Mon, 13 Apr 2026 08:10:32 +0000 (UTC)
Received: from localhost (dhcp-192-192.str.redhat.com [10.33.192.192])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10C5B19560AB;
	Mon, 13 Apr 2026 08:10:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan
 Gilbert" <dave@treblig.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric
 Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 21/27] monitor: Do not check TARGET_S390X to build
 s390x commands
In-Reply-To: <20260410195323.17937-22-philmd@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-22-philmd@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 13 Apr 2026 10:10:28 +0200
Message-ID: <87zf37b7rf.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Apr 10 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> These commands are filtered at build-time for s390x binary.
> By using the recently introduced HMPCommand::arch_bitmask flag
> we can filter them at runtime, making it possible to compile
> hmp-commands[-info].hx files once.
>
> Since the methods are used inconditionally within hw/s390x/,
> define them in the same stub file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS               |  1 +
>  include/monitor/hmp.h     |  7 +++++++
>  monitor/hmp-target.c      |  5 -----
>  stubs/hmp-cmds-hw-s390x.c | 15 +++++++++++++++
>  hmp-commands-info.hx      |  6 ++----
>  hmp-commands.hx           |  6 ++----
>  stubs/meson.build         |  1 +
>  7 files changed, 28 insertions(+), 13 deletions(-)
>  create mode 100644 stubs/hmp-cmds-hw-s390x.c

Acked-by: Cornelia Huck <cohuck@redhat.com>

