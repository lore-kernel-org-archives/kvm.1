Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493381;
	b=GIs6RThnj58MBS0bKRdo7HVUyUqOyBMRxV6zFWhrOrbKqul9NZoJyRNAeIzr9orgCa0r
	 suiPVzF1tEEvQJylKGC2sDufed/0D0txjqwpfh/QIRE8N50kMkjjVYw1DAUgjS5lKBFeA
	 IiSmZkvXUvxbeAoiBvmepdHrQl3szYP+UI8lPIaqhQ2v/sLJTn9+IK2NaHIX+3cVe2gtz
	 wkV6uuDJfNHwh9ci4UQaC+mAg8/3RNiPxIzGISbf0SaNjE355Huv8LYCJWASlf1il4hEx
	 m74rJOuOwPQI+rd+QvpfIonORz5pqtZdMA1pJ3IkH1jQ1Ho3JKmvl0ynWy7b/DPnlUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493381;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 X-Scanned-By;
	bh=pJsKiDwP7cQjHHYkeJJ5It1m2SB+6i/Xk0ZLXrFcWgM=;
	b=gUvNSo60brTVsxaMd3/gGMoscHOV2U8Ve1qFmI9fgUcuP61j6Z4BoQdoQImWRGSHjO3m
	 X7VBh7zzuFvzoXGSDPjCKfjRgTz/9cA4jWO8SsXzf4CvCh8WxKseGC3fQI5Xln6fdPRpv
	 eYfFjAA33wsXMGKDnqyLTBgc0VRx6j21CJZveHCNQK+nfpn+AI+/HOfSnEMKU4bBG2yGe
	 YQV0VMW1aLu4tL1lGkcWaJK3ooS58XqiskuSSHNtdWTk3ZgC7HD7rhS5dWACLNQcVdgw+
	 gb2KHRDCzF5qxoDua7LiJFLUjX3o5elvhDJnva50aHbbjM54l4n2ivrGwo5qFBer9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLQHVwSP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46D60A2605
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC46D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLQHVwSP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJsKiDwP7cQjHHYkeJJ5It1m2SB+6i/Xk0ZLXrFcWgM=;
	b=BLQHVwSP4y4yzoziJP2D0gjyTzL+idpS0aU1x4+ElIIkjLX63goWhyZ4XHfWKbps/inmX4
	rno6TW/C4lKJzW3t0FnT0TpTZjiAcMbwB3KE7gEXa56L6D0GVFnmd/JNUBWG30uGc+y9KI
	5ddxpKlNqRk2K2yzw4ZiRaE8lBBBZ9A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-OoWhFoGcPlaWpGKQnrYdqg-1; Tue,
 20 Oct 2026 10:49:38 +0000
X-MC-Unique: OoWhFoGcPlaWpGKQnrYdqg-1
X-Mimecast-MFC-AGG-ID: OoWhFoGcPlaWpGKQnrYdqg_1792493375
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEDA7180056E;
	Tue, 20 Oct 2026 10:49:34 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F20721956095;
	Tue, 20 Oct 2026 10:49:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:54 +0400
Subject: [PATCH v7 37/65] hw/misc/xlnx-versal-trng: add missing getter for
 fips-fault-events
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-qom-qapi-v7-37-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2e+J+3h+NUPhMCTdhI0KGfNu+o02kfLWSTEk2RShPvY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZaaRUiZcgxP4oeKcbE8gs+UJl28BKoajpQ9
 8TC/3Dz3TSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5XzVD/4vu1/c4/2gcCv9WZzxVogHqWbTFYkuxZ02zog+1m/pXb+X9tvwReTfeI9FydQAbiZpvId
 gteOK6+wAlg83zfJniCoLV7jtP+dM5FXb46UnupVcgv/SpBK4D2RejZAEufi29iApBO2oMfn9MA
 3gfevxd7THNtXegKa7wKxruBeVPEYPFhEync0+DH6wgg9EKaD4+GFKqqZ1aFNfaCLt7UzUsP7Io
 b9+cbToEVKKLoDEBVL7pnuO/RzwrBYxdHtsto9XcDx8y4g00K8cmochz1vpOtUh1O6/aPjsDzwK
 lKyeCMpsv+EwbyDSx+RRGeRZoQL3XRTFUrpQmhchGFQcMAfKsHMqjtEKGrCcBGzulk4EhNmKESi
 edlb7NLs0r0skfsaaxWorKW1rpeiTEEy7alnw7IdbIUqKy3rnu3rveuxXewnTcB5bnsDrNxwMVM
 RJ1A+85E1foSNRMRMPCuJRAvBFVzYYCaInFNaD07ePzVfR7vR1R636oNhc5efIWcOKbTVs3dJXz
 FKOIZkVWdXxVmQbuvftuGvvca4rYARfHdC0A54iqWotUPHpfdcW7NJx6aWHAQ7T4HiH7zy6MznP
 41E815xj58W8vZEWWlZSmcwXiUWFv7br2GVoiGXDN/GV9hh7gLgW1P2qn3CFsh0+V4JLm81THXE
 KiNpEqL9FN+vZmA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/xlnx-versal-trng.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index aa1d65de7b70..0584ee089e3c 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -650,10 +650,22 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
     trng_fault_event_set(XLNX_VERSAL_TRNG(obj), *events);
 }
 
+static void trng_prop_fault_event_get(Object *obj, Visitor *v,
+                                      const char *name,
+                                      void *opaque,
+                                      Error **errp)
+{
+    const Property *prop = opaque;
+    uint32_t *events = object_field_prop_ptr(obj, prop);
+
+    visit_type_uint32(v, name, events, errp);
+}
+
 static const PropertyInfo trng_prop_fault_events = {
     .type = "uint32",
     .description = "Set to trigger TRNG fault events",
     .set = trng_prop_fault_event_set,
+    .get = trng_prop_fault_event_get,
     .realized_set_allowed = true,
 };
 

-- 
2.56.0.116.g6de20f6092dc

