Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265153C3B3
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918567; cv=none; b=jjynn++iDd1hwVhqluPEO0qnyahjPjljoxZnlw7cY9IrWd8LkBfgIUOpTs5Vud875B2E2koJC9Z/mbc8ObAi1vVVgfEU9Itz7SbV0Uat09nv3fLM85O2T3AxVOt7xlNcGe47CZ03Tgq0Tf5d6Tf6ax/OCq/H6bBZh0kuY8BjUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918567; c=relaxed/simple;
	bh=KnY7puTEBrlSoKgf5txDwkeSvVbTfaBxMhDuJBqd4KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcKyg+txn4zxqrvBQ2IABwRS4zvMWmkImkY0ur8qRFkuO5iM3p2l+EqoXd3BH3xq5Ldr6Gh8ZYOnePapLdYpB1o1Zh5JPFRCRyQUlN8LAcEZ5DN8rkvL46LWA/a5EPTiCoo9naedX1ooq5I+xavUNZp5lpbZVGrQEJzqDwlbX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wed+RDUB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wed+RDUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791918565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5zgZEyxVzojLlUpj6Xv5ojPWw9NEstp7+yq+nb41Is=;
	b=Wed+RDUBiR3s4FXp5MIwADtn3U9fBWbZiP0uBxRXWd60fPEd9aCajDHXervu/NoKlVGq1U
	dWbFupBSPAFrOhNVOnZB2A24KHbr7QeIknqDVVSDKWcbP+FU17ITzHKCziFEYux6XpkQQJ
	i+vNPLBKh0CyRC9v5wxLZB0g9EztRD0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-Nk0ZBTR6OoWWEr9xIRiitA-1; Tue,
 13 Oct 2026 19:09:22 +0000
X-MC-Unique: Nk0ZBTR6OoWWEr9xIRiitA-1
X-Mimecast-MFC-AGG-ID: Nk0ZBTR6OoWWEr9xIRiitA_1791918561
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF64B182FA5A;
	Tue, 13 Oct 2026 19:09:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F31A5769;
	Tue, 13 Oct 2026 19:09:19 +0000 (UTC)
Date: Tue, 13 Oct 2026 15:09:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <20261013190919.GB1301500@shajnocz.csb>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
> I've been reviewing vsock via lore+lei for a while now.
> 
> Finally adding myself as a formal reviewer, since vsock will continue
> being stuck with me for the foreseeable future.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

