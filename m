Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7893F1AB4
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562307; cv=none; b=fT4FzMi5/7PHxr6/lQjS7l67NXvn0OyPW2lxsWl/dZIDKD/At0NYxtXME6VwAd2dKIrxhR6d3/gU3MV6cb0lOZ88ihCMWrUzFxrvD7a+Xc0ZNeqEV9kMT7BaR7gQlLW+XgwxeO88LxwuIkfoEwBDio+MysMJ426LauFFHip17BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562307; c=relaxed/simple;
	bh=88zT/qp/bsJ7dPzuyjHlk6ov0+az9NmSDemvrr8LJ2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ji4pxl0t2rLfta4WmIqeD990gFnMIWDD7lSx0YRrS96O3AcJpFRnjPfybEDNQLzr6yk/tijO6dsiiM64NvZoE0v5FObSi5Y3hVQFsfO8tMgBYd7Ch1t78EKZ8C1SxvmIdeccXhplVtITPT2BUtk6LqyvppRAllc3KikzVXjCXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPr5NQ0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPr5NQ0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787562304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U06dmekaGpyFC66yDeEENoQavmPtpQ/kkHKLHgN9cig=;
	b=WPr5NQ0C0LysGMZLjb/AHukpYfE3G/y7oTwwwbK7NcsxlveMHzfxrfKMc/ClvUPNggL9ks
	cfKDm4yks0oKL4yz8F+6wKZQ4mAL+0nhKJwpdNOGvdyg366Sre2wGP60tlnf7EVORquS2z
	qay0jsPJFEyRv05pqSc1aasceeLdW74=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-e_RA67SIM0qG1EajgxfT9w-1; Mon,
 24 Aug 2026 05:05:02 -0400
X-MC-Unique: e_RA67SIM0qG1EajgxfT9w-1
X-Mimecast-MFC-AGG-ID: e_RA67SIM0qG1EajgxfT9w_1787562301
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7C3C180AE16;
	Mon, 24 Aug 2026 09:05:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDF773000239;
	Mon, 24 Aug 2026 09:04:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Amit Machhiwal
 <amachhiw@linux.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH] linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
In-Reply-To: <deff00ce-ece0-4cdd-b1a5-90bb5e6a0835@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260819045924.11732-1-amachhiw@linux.ibm.com>
 <deff00ce-ece0-4cdd-b1a5-90bb5e6a0835@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 24 Aug 2026 11:04:57 +0200
Message-ID: <87bjarq47a.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Aug 23 2026, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:

> Hi Cornelia,
>
> Will you be picking it up sometime soon or shall I fold in with 
> respective qemu patches depending on it? Please let me know. TIA.

For headers updates, the usual process is to simply include them with
the series making use of the updates, so please just send them together
with your series.

