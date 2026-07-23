Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFC43935F
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799956; cv=none; b=daXr+oZ0MT1s+879V2ShpXzkh2vCBfG1EAabzMdM86KWm8KHW6NMkluIHsgXhC/PdsGzQ6zyBJ6HU6NUpgdTPyW7ducu3xv3K88NnVA9zA9D0ry2Tgot6lOqRIgwAVvYYYwuz4CelsC2JRMhuK3T9xAoF5Zqj6oXSzc2twnqMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799956; c=relaxed/simple;
	bh=4BoK8Zetemw4JP0KKXbZk3Gifjhn3Bu1HpbVkL08704=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nz4DZHxKZVAJI+wGVV9IPaFUQLyiMH2o4BV+OOaGBNd48dVRW9Zfi+JSo36D8lFGDD8F+LMQxyK5Ras0V38v7BZafSNnWrv4n/rWaiBBL9soQgPmKBBYPrv1ODtCRIjNBupVfxZoyut9iwJJ2g+cJ7D14B+7+siHl79N//qGnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHMTv9tg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHMTv9tg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784799952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHnEWJlXjinvwoakqaeSp8nT87Q5TfToB9OJ5Maw8bs=;
	b=PHMTv9tgW47QalO9INY/kdeWSnT/dHWiIyyOeWJV13GR14kbmv/OthEqSB85DqytdSywpm
	Ou5HwN2/SrWIKx1q5fRrcqPILJiEb9XUM9kwjEpbQOt2wknnzoxabCEaVc0lxUhffOTeoa
	iAOqX1Oik4cEfs2LuK7DWz5s7qKQ7EM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-pf030VjZOdK7KbLYmAx2-A-1; Thu,
 23 Jul 2026 05:45:49 -0400
X-MC-Unique: pf030VjZOdK7KbLYmAx2-A-1
X-Mimecast-MFC-AGG-ID: pf030VjZOdK7KbLYmAx2-A_1784799948
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A29E4195DB8E;
	Thu, 23 Jul 2026 09:45:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 196C31932B44;
	Thu, 23 Jul 2026 09:45:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7B29021E6920; Thu, 23 Jul 2026 11:45:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
In-Reply-To: <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
	("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 23 Jul 2026
 10:33:36
	+0200")
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
	<e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 11:45:44 +0200
Message-ID: <87mrvightj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Hi,
>
> On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
>> (inherited from memory_region_find()), but both SEV callers were failing
>> to release it.
>
> Comment orthogonal to your fix; odd to have a non-monitor code
> call an undocumented monitor method.

Which one?

>                                      Should the method be moved
> out of monitor/hmp-cmds.c somewhere into system/ and documented
> (likely in system/physmem.c, also moving the declaration to
> "system/memory.h")? Besides some day we should be able to build
> without monitor.
>
>> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

